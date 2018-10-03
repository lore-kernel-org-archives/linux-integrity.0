Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbeJDEIp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 00:08:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93LEToJ135076
        for <linux-integrity@vger.kernel.org>; Wed, 3 Oct 2018 17:18:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mw4tt1ynj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 03 Oct 2018 17:18:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Oct 2018 22:18:37 +0100
Subject: Re: PROBLEM: IMA xattrs not written on overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Fabian Vogt <fvogt@suse.de>
Cc: Ignaz Forster <iforster@suse.de>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 03 Oct 2018 17:18:21 -0400
In-Reply-To: <CAJfpegtk=OD6GVVOOtBT4Lto9x73vnSGdTMrzK-uTvStE6KxWw@mail.gmail.com>
References: <81a0a75d-bd4e-25ef-b41b-adb65ac6dee8@suse.de>
         <1538153671.3713.4.camel@linux.ibm.com>
         <0e1ba67f-3091-2d56-a464-07e1a8251e5e@suse.de>
         <2170726.hUdX192fWn@linux-e202.suse.de>
         <CAJfpegtk=OD6GVVOOtBT4Lto9x73vnSGdTMrzK-uTvStE6KxWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538601501.3702.217.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Miklos,

On Mon, 2018-10-01 at 11:05 +0200, Miklos Szeredi wrote:
> On Fri, Sep 28, 2018 at 9:37 PM, Fabian Vogt <fvogt@suse.de> wrote:
> > Hi,
> >
> > I'm the other person Ignaz refers to when he wrote "we".
> >
> > Am Freitag, 28. September 2018, 20:24:47 CEST schrieb Ignaz Forster:
> >> Am 28.09.18 um 18:54 schrieb Mimi Zohar:
> >> > On Mon, 2018-09-10 at 11:17 +0200, Ignaz Forster wrote:
> >> >> Am 07.09.18 um 20:45 schrieb Mimi Zohar:
> >> >>>> A small example for reproduction (on a system with IMA appraisal):
> >> >>>> # OVERLAYFS_TEST_DIR=`mktemp -d`
> >> >>>> # mkdir "${OVERLAYFS_TEST_DIR}/upper"
> >> >>>> # mkdir "${OVERLAYFS_TEST_DIR}/work"
> >> >>>> # mount -t overlay -o lowerdir=/etc,upperdir="${OVERLAYFS_TEST_DIR}
> >> >>>> /upper",workdir="${OVERLAYFS_TEST_DIR}/work" overlay /etc
> >> >>>> #
> >> >>>> # rm -f /etc/test.txt
> >> >>>> # echo Test > /etc/test.txt
> >> >>>> # cat /etc/test.txt
> >> >>>> cat: /etc/test.txt: Permission denied
> >> >>>> # ls -s /etc/test.txt
> >> >>>> 4 /etc/test.txt # <- The contents are there
> >> >>>> # getfattr -m . -d /etc/test.txt
> >> >>>> # # <- The hash isn't
> >> >>>>
> >> > The file size is still 0, when ima_check_last_writer() calls
> >> > ima_update_xattr(), which tries to calculate the file hash and write
> >> > it out an security.ima.
> >>
> >> We found out that when forcibly setting the read flag in
> >> ovl_open_realfile as seen in the attached patch the IMA attributes will
> >> be set correctly again. It seems IMA cannot read the file contents and
> >> thus cannot create the hash any more.
> >
> > In ima_crypto.c, ima_calc_file_hash_{atfm,tfm} we can find this hack (?),
> > which allows to read even through a WRONLY file:
> >
> >         if (!(file->f_mode & FMODE_READ)) {
> >                 file->f_mode |= FMODE_READ;
> >                 read = 1;
> >         }
> >
> >         integrity_kernel_read(file, ...);
> >
> >         if (read)
> >                 file->f_mode &= ~FMODE_READ;
> 
> It's not just a hack, it's a security hole: what prevents a read(2) on
> that file from userspace exploiting the window while the f_mode is
> changed?

IMA calculates the file hash either on the last write close (__fput)
or when verifying the file hash on file open.  The discussion here is
about calculating the file hash on __fput.  Before the file can be
read, the IMA file hash or signature would have to be verified first
on file open. 

Unless I'm missing something, which is totally possible, I'm not sure
there is a problem.

Mimi
