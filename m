Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36623 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbeAKN7X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jan 2018 08:59:23 -0500
Received: by mail-pg0-f66.google.com with SMTP id j2so2233231pgv.3
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2018 05:59:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515595682.5739.44.camel@linux.vnet.ibm.com>
References: <CAMXgnP4wsiu5iizCMZ4T=iPvNEa0sr_VdMP4bPibs9+Pq3nmQw@mail.gmail.com>
 <1515595150.5739.41.camel@linux.vnet.ibm.com> <20180110144418.GB4546@ubuntu-xps13>
 <1515595682.5739.44.camel@linux.vnet.ibm.com>
From: Alban Crequy <alban@kinvolk.io>
Date: Thu, 11 Jan 2018 14:59:21 +0100
Message-ID: <CADZs7q56r75QGU_7+GWHfKxuqOtnZU17GWyao2Uh+a6rVysJhA@mail.gmail.com>
Subject: Re: [PATCH] ima: define a new policy option named "force"
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Seth Forshee <seth.forshee@canonical.com>,
        Alban Crequy <alban.crequy@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        dmitry.kasatkin@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Dongsu Park <dongsu@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jan 10, 2018 at 3:48 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Wed, 2018-01-10 at 08:44 -0600, Seth Forshee wrote:
>> On Wed, Jan 10, 2018 at 09:39:10AM -0500, Mimi Zohar wrote:
>> > On Wed, 2018-01-10 at 15:13 +0100, Alban Crequy wrote:
>> > > > There are times instead of relying on previously cached status
>> > > > information we want to force the file to be re-measured, re-appraised,
>> > > > and re-audited.
>> > > >
>> > > > This patch defines a new policy option named "force", which forces
>> > > > files to be re-measured, re-appraised or re-audited.
>> > > >
>> > > > Signed-off-by: Mimi Zohar <zohar@xxxxxxxxxxxxxxxxxx>
>> > >
>> > > Tested-by: Alban Crequy <alban@kinvolk.io>
>> >
>> > Thanks!  The builtin policies should be updated to require force for
>> > fuse filesystems.  I was expecting to receive patches (from Seth) to
>> > update the builtin policies and upstream them together.
>>
>> Yes, I was working on a patch but need to update/test it. Was planning
>> to do that a few weeks ago but then other things came up, hoping I can
>> get back to it soon. But if someone beats me to it that's okay too :-)
>
> Thanks, just making sure you wouldn't object to someone else doing it ...

Thanks. Dongsu is preparing a patch to add this "force" for FUSE by default.

>> > > tl;dr: without the patch, the measurements don't get all the changes
>> > > on FUSE. With the patch and when enabling the "force" option,
>> > > ascii_runtime_measurements gets the updated measurements.

Btw, I also tested the "force" option with the memfs FUSE mounted in a
non-initial user namespace (with the FUSE patches that allow that) and
it works as well. I don't see any reasons why it would not have
worked, but I just mention it for completeness. I tested that using
"unshare -U -r -m".

Alban

>> > > Longer explanation:
>
> This "Longer explanation" would make for a really good patch
> description for changing the builtin policies.
>
> Mimi
>
>> > >
>> > > The test I did was using a patched version of the memfs FUSE driver
>> > > [1][2] and two very simple "hello-world" programs [4] (prog1 prints
>> > > "hello world: 1" and prog2 prints "hello world: 2").
>> > >
>> > > I copy prog1 and prog2 in the fuse-memfs mount point, execute them and
>> > > check the sha1 hash in
>> > > "/sys/kernel/security/ima/ascii_runtime_measurements".
>> > >
>> > > My patch on the memfs FUSE driver added a backdoor command to serve
>> > > prog1 when the kernel asks for prog2 or vice-versa. In this way, I can
>> > > exec prog1 and get it to print "hello world: 2" without ever replacing
>> > > the file via the VFS, so the kernel is not aware of the change.
>> > >
>> > > The test was done using Dongsu's branch "fuse-userns-v5-2" [3],
>> > > including both this new force option and Sascha's patch ("ima: Use
>> > > i_version only when filesystem supports it").
>> > >
>> > >
>> > > Step by step test procedure:
>> > >
>> > > 1.  Mount the memfs FUSE using [2]:
>> > > rm -f  /tmp/memfs-switch* ; memfs -L DEBUG  /mnt/memfs
>> > >
>> > > 2. Copy prog1 and prog2 using [4]
>> > > cp prog1 /mnt/memfs/prog1
>> > > cp prog2 /mnt/memfs/prog2
>> > >
>> > > 3. Lookup the files and let the FUSE driver to keep the handles open:
>> > > dd if=/mnt/memfs/prog1 bs=1 | (read -n 1 x ; sleep 3600 ) &
>> > > dd if=/mnt/memfs/prog2 bs=1 | (read -n 1 x ; sleep 3600 ) &
>> > >
>> > > 4. Check the 2 programs work correctly:
>> > > $ /mnt/memfs/prog1
>> > > hello world: 1
>> > > $ /mnt/memfs/prog2
>> > > hello world: 2
>> > >
>> > > 5.  Check the measurements for prog1 and prog2:
>> > > $ sudo cat /sys/kernel/security/ima/ascii_runtime_measurements|grep
>> > > /mnt/memfs/prog
>> > > 10 7ac5aed52061cb09120e977c6d04ee5c7b11c371 ima-ng
>> > > sha1:ac14c9268cd2811f7a5adea17b27d84f50e1122c /mnt/memfs/prog1
>> > > 10 9acc17a9a32aec4a676b8f6558e17a3d6c9a78e6 ima-ng
>> > > sha1:799cb5d1e06d5c37ae7a76ba25ecd1bd01476383 /mnt/memfs/prog2
>> > >
>> > > 6. Use the backdoor command in my patched memfs to redirect file
>> > > operations on file handle 3 to file handle 2:
>> > > rm -f  /tmp/memfs-switch* ; touch /tmp/memfs-switch-3-2
>> > >
>> > > 7. Check how the FUSE driver serves different content for the files:
>> > > $ /mnt/memfs/prog1
>> > > hello world: 2
>> > > $ /mnt/memfs/prog2
>> > > hello world: 2
>> > >
>> > > 8. Check the measurements:
>> > > sudo cat /sys/kernel/security/ima/ascii_runtime_measurements|grep
>> > > /mnt/memfs/prog
>> > >
>> > > Without the patches, on a vanilla kernel, there are no new
>> > > measurements, despite the FUSE driver having served different
>> > > executables. Same thing with the patch but without enabling the new
>> > > force option.
>> > >
>> > > However, with the "force" option enabled, I can see additional
>> > > measurements for prog1 and prog2 with the hashes reversed when the
>> > > FUSE driver served the alternative content.
>> > >
>> > >
>> > > [1] https://github.com/bbengfort/memfs
>> > > [2] https://github.com/kinvolk/memfs/commits/alban/switch-files
>> > > [3] https://github.com/kinvolk/linux/commits/dongsu/fuse-userns-v5-2
>> > > [4] https://github.com/kinvolk/fuse-userns-patches/commit/cf1f5750cab0
>> > >
>> >
>>
>
