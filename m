Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5095 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756231AbdKOIOM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 03:14:12 -0500
Date: Wed, 15 Nov 2017 10:14:09 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Azhar Shaikh <azhar.shaikh@intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy
Message-ID: <20171115081408.7jzoyxbycuw7y3w6@intel.com>
References: <1510090328-153106-1-git-send-email-azhar.shaikh@intel.com>
 <1510090328-153106-3-git-send-email-azhar.shaikh@intel.com>
 <20171114232812.GB25894@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171114232812.GB25894@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 14, 2017 at 04:28:12PM -0700, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2017 at 01:32:08PM -0800, Azhar Shaikh wrote:
> 
> > +#ifdef CONFIG_X86
> > +	if (is_bsw())
> > +		iounmap(phy->ilb_base_addr);
> > +#endif
> 
> This whole thing would be much better if is_bsw was just
> 
> bool is_bsw(void)
> { 
>    if (!IS_ENABLED(CONFIG_X86))
>        return false;
>    [..]
> }
> 
> Then drop every single one of these #ifdef CONFIG_X86
> 
> Jason

+1

/Jarkko
