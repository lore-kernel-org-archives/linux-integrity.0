Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2330 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeENK6r (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 06:58:47 -0400
Date: Mon, 14 May 2018 13:58:39 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Cc: peterhuewe@gmx.de, tweek@google.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        sonnyrao@chromium.org, enric.balletbo@collabora.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Message-ID: <20180514105839.GH8228@linux.intel.com>
References: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
 <CGME20180509001300epcas2p3971900d48408aef6a80f59b9480aac16@epcas2p3.samsung.com>
 <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 09, 2018 at 09:12:37AM +0900, Ji-Hun Kim wrote:
> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

/Jarkko
