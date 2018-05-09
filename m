Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:59920 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965017AbeEITRF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 15:17:05 -0400
Date: Thu, 10 May 2018 05:16:43 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
cc: peterhuewe@gmx.de, tweek@google.com,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        sonnyrao@chromium.org, enric.balletbo@collabora.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: replace kmalloc() + memcpy() with kmemdup()
In-Reply-To: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
Message-ID: <alpine.LRH.2.21.1805100516350.12749@namei.org>
References: <CGME20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f@epcas1p4.samsung.com> <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 9 May 2018, Ji-Hun Kim wrote:

> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
