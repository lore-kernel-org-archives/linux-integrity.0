Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729316AbeI1XT1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Sep 2018 19:19:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SGpFQY145669
        for <linux-integrity@vger.kernel.org>; Fri, 28 Sep 2018 12:54:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2msq9ytgsy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 28 Sep 2018 12:54:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 28 Sep 2018 17:54:46 +0100
Subject: Re: PROBLEM: IMA xattrs not written on overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ignaz Forster <iforster@suse.de>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Fri, 28 Sep 2018 12:54:31 -0400
In-Reply-To: <e74f411a-d3fa-6f10-9ac6-d070f7d50220@suse.de>
References: <81a0a75d-bd4e-25ef-b41b-adb65ac6dee8@suse.de>
         <1536345954.3792.173.camel@linux.ibm.com>
         <e74f411a-d3fa-6f10-9ac6-d070f7d50220@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538153671.3713.4.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-09-10 at 11:17 +0200, Ignaz Forster wrote:
> Am 07.09.18 um 20:45 schrieb Mimi Zohar:
> >> A small example for reproduction (on a system with IMA appraisal):
> >> # OVERLAYFS_TEST_DIR=`mktemp -d`
> >> # mkdir "${OVERLAYFS_TEST_DIR}/upper"
> >> # mkdir "${OVERLAYFS_TEST_DIR}/work"
> >> # mount -t overlay -o lowerdir=/etc,upperdir="${OVERLAYFS_TEST_DIR}
> >> /upper",workdir="${OVERLAYFS_TEST_DIR}/work" overlay /etc
> >> #
> >> # rm -f /etc/test.txt
> >> # echo Test > /etc/test.txt
> >> # cat /etc/test.txt
> >> cat: /etc/test.txt: Permission denied
> >> # ls -s /etc/test.txt
> >> 4 /etc/test.txt # <- The contents are there
> >> # getfattr -m . -d /etc/test.txt
> >> # # <- The hash isn't
> >>
> > 
> > Thank you for providing the example.  Also on a linux-4.18.0-rcX test
> > kernel, the file hash isn't being written out either.  The builtin
> > "appraise_tcb" policy (eg. specified as "ima_policy=appraise_tcb" on
> > the boot command) has a tmpfs dont_appraise rule.
> 
> Putting the mount point into /tmp may have been a bad example, however 
> at least on my system /tmp is mounted from a btrfs subvolume. Same with 
> /var, which I'm using for my personal tests.

The file size is still 0, when ima_check_last_writer() calls
ima_update_xattr(), which tries to calculate the file hash and write
it out an security.ima.

Mimi
