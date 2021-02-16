Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92812C433DB
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Feb 2021 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B7864D79
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Feb 2021 16:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBPQdG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:33:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:36937 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhBPQdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 11:33:06 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-47-h1rLAFRZMNSVDB9RE5cVhw-1; Tue, 16 Feb 2021 16:31:27 +0000
X-MC-Unique: h1rLAFRZMNSVDB9RE5cVhw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 16 Feb 2021 16:31:26 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 16 Feb 2021 16:31:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jarkko Sakkinen' <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v4] tpm: fix reference counting for struct tpm_chip
Thread-Topic: [PATCH v4] tpm: fix reference counting for struct tpm_chip
Thread-Index: AQHXBH2yJiAHL3ooWkeUp1zIrnNHeapa+MWQ
Date:   Tue, 16 Feb 2021 16:31:26 +0000
Message-ID: <74bbc76260594a8a8f7993ab66cca104@AcuMS.aculab.com>
References: <1613435460-4377-1-git-send-email-LinoSanfilippo@gmx.de>
 <1613435460-4377-2-git-send-email-LinoSanfilippo@gmx.de>
 <20210216125342.GU4718@ziepe.ca> <YCvtF4qfG35tHM5e@kernel.org>
In-Reply-To: <YCvtF4qfG35tHM5e@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

...
> > > +	get_device(&chip->dev);
> > > +	chip->devs.release = tpm_devs_release;
> > > +	chip->devs.devt =
> > > +		MKDEV(MAJOR(tpm_devt), chip->dev_num + TPM_NUM_DEVICES);
> 
> Isn't this less than 100 chars?

Still best kept under 80 if 'reasonable'?

Really it is just split in the wrong place:
	chip->devs.devt = MKDEV(MAJOR(tpm_devt),
					chip->dev_num + TPM_NUM_DEVICES);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

