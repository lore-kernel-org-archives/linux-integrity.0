Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:18120 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933463AbeCELLM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 06:11:12 -0500
Date: Mon, 5 Mar 2018 13:11:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: J Freyensee <why2jjj.linux@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-ID: <20180305111107.GH25377@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
 <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 01, 2018 at 02:10:17PM -0800, J Freyensee wrote:
> .
> .
> .
> I'm new to this area of the kernel, but I'm not getting these lines:
> 
> > +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> > +	tpm_buf_destroy(&buf);
> >   	if (rc <  0)
> Why is this if() check not directly after the tpm_transmit_cmd() call that
> sets rc?  Is it correct you want to destroy buf regardless of the
> tpm_transmit_cmd() outcome?
> >   		return rc;
> > -
> > -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> > +	out = (struct tpm_output_header *)buf.data;
> 
> So buf has been destroyed, buf.data sill has something valid to assign to
> out?
> > +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
> >   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> >   	return 0;
> Thanks,
> Jay

Nope it is a regression in the patch. Thank you :-) tpm_buf_destroy()
can be called if the response data is not needed other than everything
went OK (tpm_transmit_cmd() already digs this info).

/Jarkko
