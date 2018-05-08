Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:45195 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbeEHQeH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 12:34:07 -0400
Subject: Re: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <becb898c-b778-d104-5781-899599f536d4@gmail.com>
Date: Tue, 8 May 2018 09:34:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


>   		do {
> -			tpm_msleep(TPM_POLL_SLEEP);
> +			tpm_msleep(TPM_TIMEOUT_POLL);
>
I'm just curious why it was decided to still use tpm_msleep() here 
instead of usleep_range() which was used in the 2nd patch.

Otherwise,

Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
