Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeDYLGI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 07:06:08 -0400
Date: Wed, 25 Apr 2018 13:06:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH 0/3] v4.16 tpmdd backports
Message-ID: <20180425110600.GA1996@kroah.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Apr 25, 2018 at 01:44:20PM +0300, Jarkko Sakkinen wrote:
> "tpm: add retry logic" caused merge conflicts so I picked couple of
> other fixes in order to get it apply cleanly.

Are these only needed in 4.16.y?  Nothing earlier?

thanks for the backports, I'll queue them up after this next 4.16.y
kernel is released at the end of this week.

greg k-h
