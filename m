Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:8120 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeIPSBP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 14:01:15 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
CC: Jeremy Boone <Jeremy.Boone@nccgroup.trust>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "James.Bottomley@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>
Subject: RE: EXTERNAL: [PATCH v2 2/3] tpm: modify tpm_pcr_read() definition
 to pass TPM hash algorithms
Date: Sun, 16 Sep 2018 12:37:38 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9AFFC8@hasmsx108.ger.corp.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-3-roberto.sassu@huawei.com>
 <F275EFAF-C940-4E44-8164-2819503DB334@nccgroup.trust>
 <e1d77563-81fd-36f0-648f-3325969b05af@huawei.com>
 <20180916123047.GE5040@linux.intel.com>
In-Reply-To: <20180916123047.GE5040@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Wed, Sep 05, 2018 at 05:03:03PM +0200, Roberto Sassu wrote:
> > On 9/5/2018 3:43 PM, Jeremy Boone wrote:
> > > Some comments on tpm2_pcr_read below.
> > >
> > > The tpm2_pcr_read function uses TPM2_ST_NO_SESSIONS. This means
> that the response payload is not integrity protected with an HMAC. If there
> is a man-in-the-middle sitting on the serial bus that connects the TPM
> peripheral to the processor, they can tamper with the response parameters.
> > >
> > > In your changes to tpm2_pcr_read, the memcpy is now become a
> variable-length operation, instead of just copying a fixed number of bytes. If
> the MITM modifies the response field out->digest_size before it is received
> by the driver, they can make it a very large value, forcing a buffer overflow of
> the out->digest array.
> > >
> > > Adding a session to the PCR Read command seems like overkill in this
> case. I wouldn't recommend that as a solution here.  So to fix this I would
> suggest simply checking the digest size before the memcpy.
> >
> > Hi Jeremy
> >
> > ok, thanks.
> >
> > Roberto
> 
> Yeah, definitely not in the scope of this patch set. James Bottomley was
> working on sessions at some point but I'm not sure if he is still continuing
> that work or not.
> 
> In order to get sessions everywhere we would first need to get everything to
> use struct tpm_buf. Tomas Winkler was working on a patch set for this but
> that also somehow stagnated at some point.

I will send my work today out for review, I'm missing the context of this whole conversation, need to dig in the archive.
Thanks
Tomas
