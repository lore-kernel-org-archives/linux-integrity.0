Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A5C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7EB2173C
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfBZMOz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:14:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbfBZMOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 07:14:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QC9LU5038303
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 07:14:53 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qw4114q61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 07:14:53 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 12:14:52 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 12:14:50 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QCEndW31129818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 12:14:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C6434C04E;
        Tue, 26 Feb 2019 12:14:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F1E24C040;
        Tue, 26 Feb 2019 12:14:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.64])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 12:14:48 +0000 (GMT)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Markku Savela <msa@moth.iki.fi>, linux-integrity@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Date:   Tue, 26 Feb 2019 07:14:37 -0500
In-Reply-To: <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi>
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
         <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
         <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
         <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
         <1550753358.17768.85.camel@linux.ibm.com>
         <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi>
         <88215b47-976c-96d5-1098-40868d28d576@moth.iki.fi>
         <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022612-0020-0000-0000-0000031B6997
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022612-0021-0000-0000-0000216CCF51
Message-Id: <1551183277.27819.66.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-02-26 at 10:12 +0200, Markku Savela wrote:
> In case anyone is interested, I got IMA to accept TPM chip in my special 
> case (linaro optee kernel) by changing
> 
>    clk-bcm2835.c: core_initcall -> susbsys_initcall
>    raspberrypi.c: subsys_initcall -> core_initcall
> 
> At first check, the system seems to be ok. Maybe some combination of 
> initcalls could work, but this is enough for me.

Thank you for sharing this!

Mimi

> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index d6caac9c3..7cdd597f1 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -2330,7 +2330,7 @@ static int __init __bcm2835_clk_driver_init(void)
>   {
>          return platform_driver_register(&bcm2835_clk_driver);
>   }
> -core_initcall(__bcm2835_clk_driver_init);
> +subsys_initcall(__bcm2835_clk_driver_init);
> 
>   MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
>   MODULE_DESCRIPTION("BCM2835 clock driver");
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index a82819a78..dfa362e1c 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -457,7 +457,7 @@ static int __init rpi_firmware_init(void)
>   out1:
>          return ret;
>   }
> -subsys_initcall(rpi_firmware_init);
> +core_initcall(rpi_firmware_init);
> 
>   static void __init rpi_firmware_exit(void)
>   {

