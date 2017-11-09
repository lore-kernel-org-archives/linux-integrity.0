Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44295 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753451AbdKIL12 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Nov 2017 06:27:28 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13DAFAC9B
        for <linux-integrity@vger.kernel.org>; Thu,  9 Nov 2017 11:27:27 +0000 (UTC)
Date: Thu, 9 Nov 2017 12:27:22 +0100
From: Matthias Gerstner <mgerstner@suse.de>
To: linux-integrity@vger.kernel.org
Subject: btrfs UUID all zero (was: [Linux-ima-user] [PATCH] evmctl: use
 /proc/self/mountinfo instead of /dev/block/<major>:<minor>])
Message-ID: <20171109112722.4na4niefjj3uwon4@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j52aewghdaiv2yzz"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello,

referring to my own patch suggestion I've sent to the former
linux-ima-user list I have a question regarding IMA and btrfs uuid
calculation.

My patch below does fix the error message 'evmctl' gives for files
located on btrfs. But the resulting EVM digest / HMAC is not agreed upon
by the kernel side code. btrfs complicates things by having UUIDs for
subvolumes, too. After looking a bit deeper into this I found out that
in kernel function hmac_add_misc() the inode->i_sb->s_uuid is all zero
for btrfs file systems.

I was able to get things to work by passing

     -u00000000-0000-0000-0000-000000000000

to 'evmctl'. I tested this on kernel version 4.4 and 4.12.

My question is if anyone knows whether this zero UUID is a known
limitation produced by btrfs. If so then the correct patch to evmctl
would be to implicitly use all zero UUIDs for files located on btrfs
file systems.

Regards

Matthias

-- 
Matthias Gerstner <matthias.gerstner@suse.de>
Dipl.-Wirtsch.-Inf. (FH), Security Engineer
https://www.suse.com/security
Telefon: +49 911 740 53 290
GPG Key ID: 0x14C405C971923553

SUSE Linux GmbH
GF: Felix Imendorffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nuernberg)

----- Forwarded message from Matthias Gerstner <mgerstner@suse.de> -----

Date: Thu, 31 Aug 2017 17:29:36 +0200
From: Matthias Gerstner <mgerstner@suse.de>
To: linux-ima-user@lists.sourceforge.net
Subject: [Linux-ima-user] [PATCH] evmctl: use /proc/self/mountinfo instead of /dev/block/<major>:<minor>
User-Agent: NeoMutt/20170421 (1.8.2)

Some file systems like btrfs and overlayfs don't report usable st_dev
values during stat(). The result is that a command like this:

    evmctl sign --rsa --imasig -k ~/ima/ima_private.pem /some/file

fails with

    Failed to read UUID. Root access might require.
    errno: No data available (61)

Parsing /proc/self/mountinfo seems to be the usual way to get around
this limitation.
---
 src/evmctl.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c54efbb..3baa965 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -276,25 +276,90 @@ static int pack_uuid(const char *uuid_str, char *uuid)
 	return 0;
 }
 
+#define MAJ_MIN_COL 3
+#define MOUNT_SOURCE_COL 10
+
+static int get_blk_dev(dev_t dev, char *path, size_t size)
+{
+	/*
+	 * Looking in /dev/block/<major>:<minor> does not suffice for some
+	 * special file systems like btrfs or overlayfs, because their st_dev
+	 * values do not correspond to any named block device.
+	 *
+	 * Instead parse /proc/self/mountinfo for the correct source device.
+	 */
+	int ret = -1;
+	unsigned int maj = major(dev);
+	unsigned int min = minor(dev);
+	char line[LINE_MAX];
+	char maj_min_val[LINE_MAX];
+	size_t print_res = 0;
+	FILE *mountinfo = fopen("/proc/self/mountinfo", "r");
+
+	if (!mountinfo)
+		return -1;
+
+	// comparison string for the column parsing below
+	print_res = snprintf(maj_min_val, LINE_MAX, "%u:%u", maj, min);
+
+	if (print_res >= LINE_MAX)
+	{
+		// buffer to small
+		ret = -2;
+		goto out;
+	}
+
+	while (fgets(line, LINE_MAX, mountinfo) != NULL)
+	{
+		size_t column = 0;
+		char *token, *tmp_line = line;
+
+		while ( (token = strtok(tmp_line, " ")) )
+		{
+			if (tmp_line)
+				tmp_line = NULL;
+			column++;
+
+			if (column == MAJ_MIN_COL)
+			{
+				if (strcmp(token, maj_min_val) != 0)
+					// not the device we're looking for
+					break;
+			}
+			else if (column == MOUNT_SOURCE_COL)
+			{
+				print_res = snprintf(path, size, "%s", token);
+				log_debug("dev: %u:%u -> %s\n", maj, min, token);
+				ret = print_res < size ? 0 : -2;
+				goto out;
+			}
+		}
+	}
+
+	// not found or read/parse error
+	ret = -3;
+out:
+	if (mountinfo)
+		fclose(mountinfo);
+
+	return ret;
+}
+
 static int get_uuid(struct stat *st, char *uuid)
 {
-	uint32_t dev;
-	unsigned minor, major;
-	char path[PATH_MAX], _uuid[37];
+	char blkdev[PATH_MAX], cmdline[PATH_MAX], _uuid[37];
 	FILE *fp;
 	size_t len;
 
 	if (uuid_str)
 		return pack_uuid(uuid_str, uuid);
 
-	dev = st->st_dev;
-	major = (dev & 0xfff00) >> 8;
-	minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+	if (get_blk_dev(st->st_dev, blkdev, PATH_MAX) != 0)
+		goto err;
 
-	log_debug("dev: %u:%u\n", major, minor);
-	sprintf(path, "blkid -s UUID -o value /dev/block/%u:%u", major, minor);
+	snprintf(cmdline, PATH_MAX, "blkid -s UUID -o value %s", blkdev);
 
-	fp = popen(path, "r");
+	fp = popen(cmdline, "r");
 	if (!fp)
 		goto err;
 
@@ -305,7 +370,7 @@ static int get_uuid(struct stat *st, char *uuid)
 
 	return pack_uuid(_uuid, uuid);
 err:
-	log_err("Failed to read UUID. Root access might require.\n");
+	log_err("Failed to read UUID. Root access might be required.\n");
 	return -1;
 }
 
-- 
2.13.5

----- End forwarded message -----


    [ Part 2, "Digital signature"  Application/PGP-SIGNATURE (Name: ]
    [ "signature.asc") 836 bytes. ]
    [ Unable to print this part. ]
