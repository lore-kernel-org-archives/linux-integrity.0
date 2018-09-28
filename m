Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbeI2Atu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Sep 2018 20:49:50 -0400
Subject: Re: PROBLEM: IMA xattrs not written on overlayfs
To: Mimi Zohar <zohar@linux.ibm.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org
References: <81a0a75d-bd4e-25ef-b41b-adb65ac6dee8@suse.de>
 <1536345954.3792.173.camel@linux.ibm.com>
 <e74f411a-d3fa-6f10-9ac6-d070f7d50220@suse.de>
 <1538153671.3713.4.camel@linux.ibm.com>
From: Ignaz Forster <iforster@suse.de>
Cc: Fabian Vogt <fvogt@suse.de>
Message-ID: <0e1ba67f-3091-2d56-a464-07e1a8251e5e@suse.de>
Date: Fri, 28 Sep 2018 20:24:47 +0200
MIME-Version: 1.0
In-Reply-To: <1538153671.3713.4.camel@linux.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------BC1E6C429149E8EDD60E2DAE"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Am 28.09.18 um 18:54 schrieb Mimi Zohar:
> On Mon, 2018-09-10 at 11:17 +0200, Ignaz Forster wrote:
>> Am 07.09.18 um 20:45 schrieb Mimi Zohar:
>>>> A small example for reproduction (on a system with IMA appraisal):
>>>> # OVERLAYFS_TEST_DIR=`mktemp -d`
>>>> # mkdir "${OVERLAYFS_TEST_DIR}/upper"
>>>> # mkdir "${OVERLAYFS_TEST_DIR}/work"
>>>> # mount -t overlay -o lowerdir=/etc,upperdir="${OVERLAYFS_TEST_DIR}
>>>> /upper",workdir="${OVERLAYFS_TEST_DIR}/work" overlay /etc
>>>> #
>>>> # rm -f /etc/test.txt
>>>> # echo Test > /etc/test.txt
>>>> # cat /etc/test.txt
>>>> cat: /etc/test.txt: Permission denied
>>>> # ls -s /etc/test.txt
>>>> 4 /etc/test.txt # <- The contents are there
>>>> # getfattr -m . -d /etc/test.txt
>>>> # # <- The hash isn't
>>>>
> The file size is still 0, when ima_check_last_writer() calls
> ima_update_xattr(), which tries to calculate the file hash and write
> it out an security.ima.

We found out that when forcibly setting the read flag in 
ovl_open_realfile as seen in the attached patch the IMA attributes will 
be set correctly again. It seems IMA cannot read the file contents and 
thus cannot create the hash any more.

This is obviously not ready for production, but the best I currently have.

Ignaz


    [ Part 2, Text/X-PATCH (Name: "01_ima_overlay_new_file.patch") 22 ]
    [ lines. ]
    [ Unable to print this part. ]
