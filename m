Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44233 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeAJOoW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jan 2018 09:44:22 -0500
Received: from mail-io0-f198.google.com ([209.85.223.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1eZHc4-0000fi-Vk
        for linux-integrity@vger.kernel.org; Wed, 10 Jan 2018 14:44:21 +0000
Received: by mail-io0-f198.google.com with SMTP id v15so18996398iob.22
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jan 2018 06:44:20 -0800 (PST)
Date: Wed, 10 Jan 2018 08:44:18 -0600
From: Seth Forshee <seth.forshee@canonical.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Alban Crequy <alban.crequy@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        dmitry.kasatkin@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Alban Crequy <alban@kinvolk.io>, dongsu@kinvolk.io
Subject: Re: [PATCH] ima: define a new policy option named "force"
Message-ID: <20180110144418.GB4546@ubuntu-xps13>
References: <CAMXgnP4wsiu5iizCMZ4T=iPvNEa0sr_VdMP4bPibs9+Pq3nmQw@mail.gmail.com>
 <1515595150.5739.41.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1515595150.5739.41.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jan 10, 2018 at 09:39:10AM -0500, Mimi Zohar wrote:
> On Wed, 2018-01-10 at 15:13 +0100, Alban Crequy wrote:
> > > There are times instead of relying on previously cached status
> > > information we want to force the file to be re-measured, re-appraised,
> > > and re-audited.
> > >
> > > This patch defines a new policy option named "force", which forces
> > > files to be re-measured, re-appraised or re-audited.
> > >
> > > Signed-off-by: Mimi Zohar <zohar@xxxxxxxxxxxxxxxxxx>
> > 
> > Tested-by: Alban Crequy <alban@kinvolk.io>
> 
> Thanks!  The builtin policies should be updated to require force for
> fuse filesystems.  I was expecting to receive patches (from Seth) to
> update the builtin policies and upstream them together.

Yes, I was working on a patch but need to update/test it. Was planning
to do that a few weeks ago but then other things came up, hoping I can
get back to it soon. But if someone beats me to it that's okay too :-)

Seth

> 
> Mimi
> 
> > 
> > tl;dr: without the patch, the measurements don't get all the changes
> > on FUSE. With the patch and when enabling the "force" option,
> > ascii_runtime_measurements gets the updated measurements.
> > 
> > 
> > Longer explanation:
> > 
> > The test I did was using a patched version of the memfs FUSE driver
> > [1][2] and two very simple "hello-world" programs [4] (prog1 prints
> > "hello world: 1" and prog2 prints "hello world: 2").
> > 
> > I copy prog1 and prog2 in the fuse-memfs mount point, execute them and
> > check the sha1 hash in
> > "/sys/kernel/security/ima/ascii_runtime_measurements".
> > 
> > My patch on the memfs FUSE driver added a backdoor command to serve
> > prog1 when the kernel asks for prog2 or vice-versa. In this way, I can
> > exec prog1 and get it to print "hello world: 2" without ever replacing
> > the file via the VFS, so the kernel is not aware of the change.
> > 
> > The test was done using Dongsu's branch "fuse-userns-v5-2" [3],
> > including both this new force option and Sascha's patch ("ima: Use
> > i_version only when filesystem supports it").
> > 
> > 
> > Step by step test procedure:
> > 
> > 1.  Mount the memfs FUSE using [2]:
> > rm -f  /tmp/memfs-switch* ; memfs -L DEBUG  /mnt/memfs
> > 
> > 2. Copy prog1 and prog2 using [4]
> > cp prog1 /mnt/memfs/prog1
> > cp prog2 /mnt/memfs/prog2
> > 
> > 3. Lookup the files and let the FUSE driver to keep the handles open:
> > dd if=/mnt/memfs/prog1 bs=1 | (read -n 1 x ; sleep 3600 ) &
> > dd if=/mnt/memfs/prog2 bs=1 | (read -n 1 x ; sleep 3600 ) &
> > 
> > 4. Check the 2 programs work correctly:
> > $ /mnt/memfs/prog1
> > hello world: 1
> > $ /mnt/memfs/prog2
> > hello world: 2
> > 
> > 5.  Check the measurements for prog1 and prog2:
> > $ sudo cat /sys/kernel/security/ima/ascii_runtime_measurements|grep
> > /mnt/memfs/prog
> > 10 7ac5aed52061cb09120e977c6d04ee5c7b11c371 ima-ng
> > sha1:ac14c9268cd2811f7a5adea17b27d84f50e1122c /mnt/memfs/prog1
> > 10 9acc17a9a32aec4a676b8f6558e17a3d6c9a78e6 ima-ng
> > sha1:799cb5d1e06d5c37ae7a76ba25ecd1bd01476383 /mnt/memfs/prog2
> > 
> > 6. Use the backdoor command in my patched memfs to redirect file
> > operations on file handle 3 to file handle 2:
> > rm -f  /tmp/memfs-switch* ; touch /tmp/memfs-switch-3-2
> > 
> > 7. Check how the FUSE driver serves different content for the files:
> > $ /mnt/memfs/prog1
> > hello world: 2
> > $ /mnt/memfs/prog2
> > hello world: 2
> > 
> > 8. Check the measurements:
> > sudo cat /sys/kernel/security/ima/ascii_runtime_measurements|grep
> > /mnt/memfs/prog
> > 
> > Without the patches, on a vanilla kernel, there are no new
> > measurements, despite the FUSE driver having served different
> > executables. Same thing with the patch but without enabling the new
> > force option.
> > 
> > However, with the "force" option enabled, I can see additional
> > measurements for prog1 and prog2 with the hashes reversed when the
> > FUSE driver served the alternative content.
> > 
> > 
> > [1] https://github.com/bbengfort/memfs
> > [2] https://github.com/kinvolk/memfs/commits/alban/switch-files
> > [3] https://github.com/kinvolk/linux/commits/dongsu/fuse-userns-v5-2
> > [4] https://github.com/kinvolk/fuse-userns-patches/commit/cf1f5750cab0
> > 
> 
