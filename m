Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B0C31681
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF60720879
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfAURJQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:09:16 -0500
Received: from maillog.nuvoton.com ([202.39.227.15]:41084 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfAURJP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 12:09:15 -0500
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 12:09:15 EST
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id D626E1C80950;
        Tue, 22 Jan 2019 00:55:28 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 22 Jan 2019
 00:55:27 +0800
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Mon, 21 Jan
 2019 18:55:24 +0200
Received: from NTILML02.nuvoton.com ([::1]) by NTILML02.nuvoton.com ([::1])
 with mapi id 15.00.1130.005; Mon, 21 Jan 2019 18:55:24 +0200
From:   <oshri.alkoby@nuvoton.com>
To:     <Dan.Morav@nuvoton.com>, <jgg@ziepe.ca>
CC:     <nayna@linux.vnet.ibm.com>, <dana.cohen@nuvoton.com>,
        <linux-integrity@vger.kernel.org>, <gcwilson@us.ibm.com>
Subject: RE: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Topic: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Index: AQHUr0NnAtI+NFiTokGDUz1xZWqLqqW4UMeggACQpgCAAOD0kIAALjvA
Date:   Mon, 21 Jan 2019 16:55:23 +0000
Message-ID: <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
 <20190121022640.GD18017@ziepe.ca>
 <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
In-Reply-To: <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [72.182.52.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jason,

Since the driver implements the I2C interface defined by the TCG PTP, wouldn't it be better to set the string to be something like 'tcg,tpm-i2c-ptp' (as 'tcg,tpm-tis-mmio' for tpm-tis)?
Any TPM that implements this protocol can use this driver.

Oshri

-----Original Message-----
From: IS30 Dan Morav
Sent: Monday, January 21, 2019 7:52 AM
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: nayna@linux.vnet.ibm.com; IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>; IS30 Dana Cohen <dana.cohen@nuvoton.com>; linux-integrity@vger.kernel.org; gcwilson@us.ibm.com
Subject: RE: device tree "compatible" string value for Nuvoton TPM 75xxx

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
