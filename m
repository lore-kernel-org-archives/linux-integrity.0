Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbeIGX2R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Sep 2018 19:28:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87IhtUm031811
        for <linux-integrity@vger.kernel.org>; Fri, 7 Sep 2018 14:46:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mbtxgsk1s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Sep 2018 14:46:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 7 Sep 2018 19:45:59 +0100
Subject: Re: PROBLEM: IMA xattrs not written on overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ignaz Forster <iforster@suse.de>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Date: Fri, 07 Sep 2018 14:45:54 -0400
In-Reply-To: <81a0a75d-bd4e-25ef-b41b-adb65ac6dee8@suse.de>
References: <81a0a75d-bd4e-25ef-b41b-adb65ac6dee8@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1536345954.3792.173.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-09-07 at 18:49 +0200, Ignaz Forster wrote:
> Hi,
> 
> I'm currently experimenting with IMA / EVM on overlayfs, however those 
> don't seem to work together very well.
> 
> With kernel 4.18 it was possible to at least partially use IMA. As long 
> as the O_TRUNC attribute was not set during a copy_up operation 
> everything seemed to work so far.
> 
> Now when applying the changes from 
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git/tag/?h=ovl-update-4.19 
> (or using kernel 4.19-rc2) every file contents modification or creation 
> of a new file will fail, probably because the inode reported by 
> overlayfs does not match the physical inode number any more (and thus 
> the IMA hashes won't be generated).
> 
> 
> A small example for reproduction (on a system with IMA appraisal):
> # OVERLAYFS_TEST_DIR=`mktemp -d`
> # mkdir "${OVERLAYFS_TEST_DIR}/upper"
> # mkdir "${OVERLAYFS_TEST_DIR}/work"
> # mount -t overlay -o lowerdir=/etc,upperdir="${OVERLAYFS_TEST_DIR} 
> /upper",workdir="${OVERLAYFS_TEST_DIR}/work" overlay /etc
> #
> # rm -f /etc/test.txt
> # echo Test > /etc/test.txt
> # cat /etc/test.txt
> cat: /etc/test.txt: Permission denied
> # ls -s /etc/test.txt
> 4 /etc/test.txt # <- The contents are there
> # getfattr -m . -d /etc/test.txt
> # # <- The hash isn't
> 

Thank you for providing the example.  Also on a linux-4.18.0-rcX test
kernel, the file hash isn't being written out either.  The builtin
"appraise_tcb" policy (eg. specified as "ima_policy=appraise_tcb" on
the boot command) has a tmpfs dont_appraise rule.

> After some debugging I'm not sure on how to continue from here. My 
> assumption is that overlayfs will have to be modified, however I fail to 
> see where to start.

Please make sure that you're comparing the results based on using the
same IMA policy.

Mimi
