Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFCC43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 14:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E69217F5
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 14:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfBZOE5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:04:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbfBZOE5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 09:04:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QDxinI014408
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 09:04:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qw6dntfmn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 09:04:55 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 14:04:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 14:04:51 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QE4o6831654100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 14:04:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A9524C04A;
        Tue, 26 Feb 2019 14:04:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95AED4C046;
        Tue, 26 Feb 2019 14:04:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.64])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 14:04:49 +0000 (GMT)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Markku Savela <msa@moth.iki.fi>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Date:   Tue, 26 Feb 2019 09:04:38 -0500
In-Reply-To: <CAKv+Gu9H=yP8McwmsBP5nk-Fc3YHG2GF2zU+00gB4sqtfafyeg@mail.gmail.com>
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
         <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
         <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
         <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
         <1550753358.17768.85.camel@linux.ibm.com>
         <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi>
         <88215b47-976c-96d5-1098-40868d28d576@moth.iki.fi>
         <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi>
         <1551183277.27819.66.camel@linux.ibm.com>
         <CAKv+Gu9H=yP8McwmsBP5nk-Fc3YHG2GF2zU+00gB4sqtfafyeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022614-0020-0000-0000-0000031B73CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022614-0021-0000-0000-0000216CDA3F
Message-Id: <1551189878.27819.86.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260103
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Jarkko]

On Tue, 2019-02-26 at 13:38 +0100, Ard Biesheuvel wrote:
> On Tue, 26 Feb 2019 at 13:14, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-02-26 at 10:12 +0200, Markku Savela wrote:
> > > In case anyone is interested, I got IMA to accept TPM chip in my special
> > > case (linaro optee kernel) by changing
> > >
> > >    clk-bcm2835.c: core_initcall -> susbsys_initcall
> > >    raspberrypi.c: subsys_initcall -> core_initcall
> > >
> > > At first check, the system seems to be ok. Maybe some combination of
> > > initcalls could work, but this is enough for me.
> >
> > Thank you for sharing this!
> >
> > Mimi
> >
> 
> Hi Mimi, Markku,
> 
> I am not sure why I am being cc'ed on this thread, or if there is
> anything particular you would like my opinion on.

Hi Ard, thank you for responding.  The clk not being initialized early
enough has been a problem for years.  Because of the clk not being
initialized, the TPM initialization is deferred, causing IMA to go
into TPM-bypass mode.

> 
> In general, having to juggle initcall ordering like this is horrid, so
> while useful as a data point, I'd prefer fixing it properly instead.
> I.e., if the firmware driver relies on a clock having been enabled,
> this should be reflected in the DT, and supported in the firmware
> driver by deferring the probe until the clock becomes available.

If a DT change could resolve this problem, that would be wonderful.

Mimi

> 
> 
> > >
> > > diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> > > index d6caac9c3..7cdd597f1 100644
> > > --- a/drivers/clk/bcm/clk-bcm2835.c
> > > +++ b/drivers/clk/bcm/clk-bcm2835.c
> > > @@ -2330,7 +2330,7 @@ static int __init __bcm2835_clk_driver_init(void)
> > >   {
> > >          return platform_driver_register(&bcm2835_clk_driver);
> > >   }
> > > -core_initcall(__bcm2835_clk_driver_init);
> > > +subsys_initcall(__bcm2835_clk_driver_init);
> > >
> > >   MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
> > >   MODULE_DESCRIPTION("BCM2835 clock driver");
> > > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> > > index a82819a78..dfa362e1c 100644
> > > --- a/drivers/firmware/raspberrypi.c
> > > +++ b/drivers/firmware/raspberrypi.c
> > > @@ -457,7 +457,7 @@ static int __init rpi_firmware_init(void)
> > >   out1:
> > >          return ret;
> > >   }
> > > -subsys_initcall(rpi_firmware_init);
> > > +core_initcall(rpi_firmware_init);
> > >
> > >   static void __init rpi_firmware_exit(void)
> > >   {
> >
> 

