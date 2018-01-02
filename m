Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752861AbeABOqL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 09:46:11 -0500
Date: Tue, 2 Jan 2018 16:46:06 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: remove unused data fields from I2C and OF device
 ID tables
Message-ID: <20180102144606.mqrhezjnxhvtgjwn@linux.intel.com>
References: <20171222174741.21534-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222174741.21534-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 22, 2017 at 06:47:41PM +0100, Javier Martinez Canillas wrote:
> The data field for the entries in the device tables are set but not used.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
