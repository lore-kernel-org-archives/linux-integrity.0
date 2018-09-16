Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27673 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbeIQAvU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 20:51:20 -0400
Date: Sun, 16 Sep 2018 22:21:15 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "James.Bottomley@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>
Subject: Re: EXTERNAL: [PATCH v2 2/3] tpm: modify tpm_pcr_read() definition
 to pass TPM hash algorithms
Message-ID: <20180916192115.GE7473@linux.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-3-roberto.sassu@huawei.com>
 <F275EFAF-C940-4E44-8164-2819503DB334@nccgroup.trust>
 <e1d77563-81fd-36f0-648f-3325969b05af@huawei.com>
 <20180916123047.GE5040@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9AFFC8@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9AFFC8@hasmsx108.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Sep 16, 2018 at 12:37:38PM +0000, Winkler, Tomas wrote:
> > On Wed, Sep 05, 2018 at 05:03:03PM +0200, Roberto Sassu wrote:
> > > On 9/5/2018 3:43 PM, Jeremy Boone wrote:
> > > > Some comments on tpm2_pcr_read below.
> > > >
> > > > The tpm2_pcr_read function uses TPM2_ST_NO_SESSIONS. This means
> > that the response payload is not integrity protected with an HMAC. If there
> > is a man-in-the-middle sitting on the serial bus that connects the TPM
> > peripheral to the processor, they can tamper with the response parameters.
> > > >
> > > > In your changes to tpm2_pcr_read, the memcpy is now become a
> > variable-length operation, instead of just copying a fixed number of bytes. If
> > the MITM modifies the response field out->digest_size before it is received
> > by the driver, they can make it a very large value, forcing a buffer overflow of
> > the out->digest array.
> > > >
> > > > Adding a session to the PCR Read command seems like overkill in this
> > case. I wouldn't recommend that as a solution here.  So to fix this I would
> > suggest simply checking the digest size before the memcpy.
> > >
> > > Hi Jeremy
> > >
> > > ok, thanks.
> > >
> > > Roberto
> > 
> > Yeah, definitely not in the scope of this patch set. James Bottomley was
> > working on sessions at some point but I'm not sure if he is still continuing
> > that work or not.
> > 
> > In order to get sessions everywhere we would first need to get everything to
> > use struct tpm_buf. Tomas Winkler was working on a patch set for this but
> > that also somehow stagnated at some point.
> 
> I will send my work today out for review, I'm missing the context of this whole conversation, need to dig in the archive.
> Thanks
> Tomas
> 

Great, thank you.

/Jarkko
