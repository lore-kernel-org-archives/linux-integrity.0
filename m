Return-Path: <SRS0=YknM=NJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29933C0044C
	for <linux-integrity@archiver.kernel.org>; Mon, 29 Oct 2018 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE07E20657
	for <linux-integrity@archiver.kernel.org>; Mon, 29 Oct 2018 14:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE07E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeJ2XKs (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:10:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:8992 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeJ2XKs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Oct 2018 19:10:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 07:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="99667785"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.111])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2018 07:21:51 -0700
Date:   Mon, 29 Oct 2018 16:21:50 +0200 (EET)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
cc:     Victor Gonzalo <victor.gonzalo@blancco.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
Subject: RE: PPI TPM2 commands
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C00EDA8DF7@ALPMBAPA12.e2k.ad.ge.com>
Message-ID: <alpine.DEB.2.21.1810291618060.28525@jsakkine-mobl1>
References: <AM3PR05MB1409B0601A0E9DA351623E519EF00@AM3PR05MB1409.eurprd05.prod.outlook.com> <BCA04D5D9A3B764C9B7405BBA4D4A3C00EDA8DF7@ALPMBAPA12.e2k.ad.ge.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1713442877-1540822912=:28525"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1713442877-1540822912=:28525
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 29 Oct 2018, Safford, David (GE Global Research, US) wrote:
>> Hello
>>   I'm trying to issue TPM2.0 PPI commands (operation > 22) with no success.
>> Is there any known issue with it?
>>
>> Is there a reason PPI_TPM_REQ_MAX is set to 22? Could it be set to 127 so
>> we can check in tcg_operations which commands are implemented or not?
>>
>> Thanks
>> -Víctor Gonzalo
>
> The current tpm_ppi.c driver is a bit dated.
> It does not recognize v 1.3 correctly, it does not support commands with arguments,
> (23 requires the bank bitmask as an argument), and it limits the display to < 23.
> I'm working on a patch, and have successfully issued 23 (PCR_Allocate).
>
> Note that not all vendors implement 23 as it could lock users out of Bitlocker systems.
> My HP Spectre does, but apparently Dell's don't in general. I was planning on
> sampling different systems once the driver update is working.
>
> dave

Dave, I would suggest to document the PPI interface under while you
refine the interface:

Documentation/security/tpm/

Would be very useful to have a simple plain text document there that
explains how to use the sysfs interface and what each command do
rather than having to always look them up from TCG specs.

This would be a good time as this will add more complexity to the
interface.

/Jarkko
--8323329-1713442877-1540822912=:28525--
