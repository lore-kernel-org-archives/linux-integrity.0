Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:48844 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751727AbeCMPHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Mar 2018 11:07:36 -0400
From: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-ima-devel@lists.sourceforge.net"
        <linux-ima-devel@lists.sourceforge.net>,
        "linux-ima-user@lists.sourceforge.net"
        <linux-ima-user@lists.sourceforge.net>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 13 Mar 2018 12:57:54 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <1520893847.4522.62.camel@HansenPartnership.com>
         <1520897400.3547.253.camel@linux.vnet.ibm.com>
 <1520899605.4522.67.camel@HansenPartnership.com>
In-Reply-To: <1520899605.4522.67.camel@HansenPartnership.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com]
> Sent: Monday, March 12, 2018 8:07 PM
> To: Mimi Zohar <zohar@linux.vnet.ibm.com>; Jiandi An
> <anjiandi@codeaurora.org>; Jason Gunthorpe <jgg@ziepe.ca>
> Cc: dmitry.kasatkin@gmail.com; jmorris@namei.org; serge@hallyn.com;
> linux-integrity@vger.kernel.org; linux-ima-devel@lists.sourceforge.net;
> linux-ima-user@lists.sourceforge.net; linux-security-
> module@vger.kernel.org; linux-kernel@vger.kernel.org; Safford, David (GE
> Global Research, US) <david.safford@ge.com>
> Subject: EXT: Re: [PATCH] security: Fix IMA Kconfig for dependencies on
> ARM64
> 
> On Mon, 2018-03-12 at 19:30 -0400, Mimi Zohar wrote:
> > On Mon, 2018-03-12 at 15:30 -0700, James Bottomley wrote:
> > >
> > > On Mon, 2018-03-12 at 17:53 -0400, Mimi Zohar wrote:
> > [...]
> > >
> > > >
> > > > - This use case, when the TPM is not builtin and unavailable
> > > > before IMA is initialized.
> > > >
> > > > I would classify this use case as an IMA testing/debugging
> > > > environment, when it cannot, for whatever reason, be builtin the
> > > > kernel or initialized before IMA.
> > > >
> > > > From Dave Safford:
> > > >     For the TCG chain of trust to have any meaning, all files have
> > > > to
> > > >     be measured and extended into the TPM before they are
> > > > accessed.
> > > > If
> > > >     the TPM driver is loaded after any unmeasured file, the chain
> > > > is
> > > >     broken, and IMA is useless for any use case or any threat
> > > > model.
> > >
> > > I don't think this is quite the correct characterisation.  In
> > > principle the kernel could also touch the files before IMA is
> > > loaded.  However, we know from the way the kernel operates that it
> > > doesn't.  We basically trust that the kernel measurement tells us
> > > this.  The same thing can be made to apply to the initrd.
> >
> > With the builtin "tcb" policy, IMA-measurement is enabled from the
> > very beginning.  Afterwards, the system can transition to a custom
> > policy based on finer grain LSM labels, which aren't available on
> > boot.
> >
> > >
> > > The key question is not whether the component could theoretically
> > > access the files but whether it actually does so.
> >
> > As much as you might think you know what is included in the initramfs,
> > IMA-measurement is your safety net, including everything accessed in
> > the TCB.
> 
> The initrd *is* part of the Trusted Computing Base because it's part of the
> boot custody chain.  That's really my point.  If I don't know what's in my initrd,
> I've broken the chain there and IMA can't fix it.
> 
> James

That's exactly the point - how do you know what's in your initrd?
The initrd is normally built on the possibly compromised system in question.
It's not signed as a whole by someone trusted. How can the attestation
server say a given hash of the initrd as a whole is good?

If IMA is running from the very start, it can at least measure (and eventually appraise)
every individual file in the initrd. Given this more detailed measurement list, the
attestation server can verify all the components in the initrd, even when it is
assembled on the untrusted system.

On many embedded systems, there is no initrd, and IMA has to start measuring
and appraising immediately, anyway.

Perhaps there is a use case where there is a known set of initrd images, 
and so the bootloader's measurement of the initrd is sufficient for verification.
I've not run into that situation yet. If you want an option for this use case, 
that's fine, (I'm all for choice) but it should not be the default for IMA.

dave
