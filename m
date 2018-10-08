Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbeJIFyp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 01:54:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98MY9aH005288
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 18:40:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n0cefyvqj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 18:40:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 23:40:37 +0100
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Mon, 08 Oct 2018 18:40:32 -0400
In-Reply-To: <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
         <1538997900.15382.90.camel@linux.ibm.com>
         <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539038432.15382.181.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-10-08 at 13:19 -0700, Matthew Garrett wrote:
> On Mon, Oct 8, 2018 at 4:25 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Fri, 2018-10-05 at 12:25 -0700, Matthew Garrett wrote:

> > > I agree that using FUSE in general is incompatible with IMA's goals,
> > > but it's possible to configure systems where you can ensure that only
> > > trustworthy code is involved. In that scenario this patch improves
> > > performance without compromising security.
> >
> > If you trust a FUSE filesystem to not only behave properly, but also
> > to return file hashes, what is the value of measuring/appraising the
> > files?  Define a custom policy that doesn't measure/appraise files on
> > FUSE filesystems.
> 
> We trust that the filesystem will return us accurate binaries and
> hashes, but we don't the binaries themselves may not be trustworthy -
> we want the same level of audit trail associated with their execution
> that we'd have for something run off local disk. We could certainly
> rearchitect our filesystems to generate audit events themselves, but
> we'd be duplicating functionality that already exists in the kernel.

I'm really not comfortable with the FUSE filesystem calculating the
file hash being used by IMA.  Adding FUSE i_version support would have
been better, instead of returning the actual file hash.  Based on a
mount option and the i_version, the kernel could then decide whether
or not to limit re-calculating the file hash.

Mimi
