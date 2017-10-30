Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752821AbdJ3LgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 07:36:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9UBZcBW055972
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 07:36:18 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dx254bwpg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 07:36:17 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 30 Oct 2017 11:36:15 -0000
Subject: Re: [RFC] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Date: Mon, 30 Oct 2017 07:36:11 -0400
In-Reply-To: <CACdnJuv1n7LnWj4Oo=B+nOQQz--RFhEAvLTF1oMzcY_kqE-x6w@mail.gmail.com>
References: <20171026083144.16247-1-mjg59@google.com>
         <20171026120330.5360e427@totoro>
         <CACdnJuvQUGXJb664ZVJk6Z_YDYomgRSwX_C3vk4DRk5EVj02Gg@mail.gmail.com>
         <20171026124616.2f2ef1d2@totoro>
         <1509045773.5886.93.camel@linux.vnet.ibm.com>
         <CACdnJuv1n7LnWj4Oo=B+nOQQz--RFhEAvLTF1oMzcY_kqE-x6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509363371.3583.39.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-30 at 10:53 +0000, Matthew Garrett wrote:
> On Thu, Oct 26, 2017 at 8:22 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Thu, 2017-10-26 at 12:46 +0300, Mikhail Kurinnoi wrote:
> >> ? Thu, 26 Oct 2017 02:08:25 -0700
> >> Matthew Garrett <mjg59@google.com> ?????:
> >> > That's fine - policy may not care. It's easier to sign all files and
> >> > then leave enforcement up to the local policy than it is to determine
> >> > in advance which files will need protection.
> >
> > You're both correct.  Signing the file data will prevent security.ima
> > from changing, assuming the file is in policy and there is a
> > FILE_CHECK rule.  We're requiring the signed file-metadata include
> > security.ima, but it currently doesn't require it to contain a file
> > signature.  Only having a single file signature, was one of Matthew's
> > requirements.
> >
> > IMA accessing the EVM flags crosses the boundary between EVM/IMA. Just
> > as the LSMs protect their own xattr label, EVM should protect
> > security.evm, preventing it from changing.  There's no need for the
> > test here in IMA.
> 
> Ok - so the preferred approach here would be to allow updating of
> security.ima if it's a hash rather than a digsig, and then have EVM
> validation fail later? That seems reasonable to me, but it'll mean
> reworking the EVM side a little in order to ensure that the EVM
> signature doesn't get rewritten into an HMAC in response.
> 
> >> Hmm...
> >> http://www.spinics.net/lists/linux-integrity/msg00151.html
> >>
> >> probably, we should decide first, what exactly immutable EVM mean.
> >> It's hard to propose something or test patch if we still have
> >> misunderstanding in concept of immutable EVM.
> >
> > Agreed.  I think EVM should prevent any changes to the file metadata
> > that would cause the portable/immutable EVM signature to be invalid.
> >  For example, the change in evm_inode_setattr() permits the file
> > metadata to change.  The same is true for removing files or writing
> > security xattrs.
> 
> This seems to run counter to there being no linkage between EVM and
> IMA. If IMA is unaware that there's an EVM digital signature then it
> has no way of knowing that security.ima shouldn't be updated.

This patch should be responsible for security.evm not changing, making
it immutable.  An additional patch would check the return code from
evm_verifyxattr(), as Mikhail said.

> The scenario that I want is basically the following:
> 
> 1) New files with portable signatures can be written to the filesystem
> even if EVM is active

Agreed, that is similar to the existing EVM signature.

> 2) It should be possible to write a policy that allows these files to
> be arbitrarily modified, including being deleted

File deletion is not the problem, but if we allow the file metadata to
change, then the file verification will fail.   

> I'd been interpreting "immutable" in this case to mean "the kernel
> will never replace the signature with an hmac" rather than "the file
> and protected information cannot be modified". If you think the latter
> is necessary then I think we need two separate signature types and to
> handle the two separately.

EVM, up to now, is reactive to file data and meta-data changes,
replacing the file signature with an HMAC.  For the new file signature
to be immutable it needs to prevent security.evm from changing, which
this patch currently does not do.

We've already discussed that preventing the file data from changing is
an IMA issue, which should be addressed in a separate patch by IMA.
 That leaves us with file metadata changes.

So the question is not whether EVM will re-write security.evm, but
whether it returns an error, preventing the file metadata from
changing.
