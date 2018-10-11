Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45818 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeJLDqz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 23:46:55 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>
CC: "nayna@linux.vnet.ibm.com" <nayna@linux.vnet.ibm.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/21] tpm: factor out tpm_get_timeouts()
Date: Thu, 11 Oct 2018 20:16:34 +0000
Message-ID: <1539288758.1669.15.camel@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
         <20180928223035.14471-6-tomas.winkler@intel.com>
         <b6b0fb96-e955-bf86-9bac-e6acee1e33e0@linux.ibm.com>
In-Reply-To: <b6b0fb96-e955-bf86-9bac-e6acee1e33e0@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-10-11 at 22:30 +0530, Nayna Jain wrote:
> 
> On 09/29/2018 04:00 AM, Tomas Winkler wrote:
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 73511cd89bef..a97d72fcda5b 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -544,8 +544,10 @@ int tpm_startup(struct tpm_chip *chip);
> >   ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
> >   		   const char *desc, size_t min_cap_length);
> >   int tpm_get_timeouts(struct tpm_chip *);
> > -int tpm1_auto_startup(struct tpm_chip *chip);
> >   int tpm_do_selftest(struct tpm_chip *chip);
> > +
> > +int tpm1_auto_startup(struct tpm_chip *chip);
> 
> What is different in this tpm1_auto_startup(...) and the original one ?
> 
> Is this needed ?
Looks like an amending  hiccup, will fix.
Thanks
Tomas
