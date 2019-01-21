Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C715C2F3A0
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0212920861
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfAUNvr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:47 -0500
Received: from maillog.nuvoton.com ([202.39.227.15]:37520 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfAUNvq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:46 -0500
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 71CE71C80508;
        Mon, 21 Jan 2019 21:51:44 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Mon, 21 Jan 2019
 21:51:43 +0800
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Mon, 21 Jan
 2019 15:51:41 +0200
Received: from NTILML02.nuvoton.com ([::1]) by NTILML02.nuvoton.com ([::1])
 with mapi id 15.00.1130.005; Mon, 21 Jan 2019 15:51:41 +0200
From:   <Dan.Morav@nuvoton.com>
To:     <jgg@ziepe.ca>
CC:     <nayna@linux.vnet.ibm.com>, <oshri.alkoby@nuvoton.com>,
        <dana.cohen@nuvoton.com>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>
Subject: RE: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Topic: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Index: AQHUr0NnAtI+NFiTokGDUz1xZWqLqqW4UMeggACQpgCAAOD0kA==
Date:   Mon, 21 Jan 2019 13:51:40 +0000
Message-ID: <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
 <20190121022640.GD18017@ziepe.ca>
In-Reply-To: <20190121022640.GD18017@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.191.10.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jason,

Thank you for the feedback. We will follow.

Regards,
Dan.


-----Original Message-----
From: Jason Gunthorpe <jgg@ziepe.ca>
Sent: Monday, 21 January, 2019 04:27
To: IS30 Dan Morav <Dan.Morav@nuvoton.com>
Cc: nayna@linux.vnet.ibm.com; IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>; IS30 Dana Cohen <dana.cohen@nuvoton.com>; linux-integrity@vger.kernel.org; gcwilson@us.ibm.com
Subject: Re: device tree "compatible" string value for Nuvoton TPM 75xxx

On Sun, Jan 20, 2019 at 03:53:46PM +0000, Dan.Morav@nuvoton.com wrote:
> Hi,
>
> I've added Oshri who has been working on the driver, and Dana who is the TPM applications for follow up.
> I'd suggest "npct75x" to continue with the same line.

There are rules for the compatible strings.. Generaly they shouldn't include x's if I recall.

If future chips are compatible with a first release then it should be something like

'nuvoton,npct751','nuvoton,npct750'

Be sure to check with the device tree people

Jason


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
