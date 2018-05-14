Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10210 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbeENK6T (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 06:58:19 -0400
Date: Mon, 14 May 2018 13:58:12 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Cc: peterhuewe@gmx.de, tweek@google.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        sonnyrao@chromium.org, enric.balletbo@collabora.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Message-ID: <20180514105812.GG8228@linux.intel.com>
References: <CGME20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f@epcas1p4.samsung.com>
 <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 09, 2018 at 09:12:36AM +0900, Ji-Hun Kim wrote:
> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
