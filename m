Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75388C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485A121852
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 19:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfBZTFb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:05:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728768AbfBZTFb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 14:05:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QJ4G3X100091
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 14:05:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw99gq5vk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 14:05:29 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 19:05:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 19:05:24 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QJ5N5i35258408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 19:05:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DBE011C050;
        Tue, 26 Feb 2019 19:05:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91EED11C04C;
        Tue, 26 Feb 2019 19:05:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 19:05:22 +0000 (GMT)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Markku Savela <msa@moth.iki.fi>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Date:   Tue, 26 Feb 2019 14:05:11 -0500
In-Reply-To: <20190226180913.GA22368@linux.intel.com>
References: <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
         <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
         <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
         <1550753358.17768.85.camel@linux.ibm.com>
         <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi>
         <88215b47-976c-96d5-1098-40868d28d576@moth.iki.fi>
         <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi>
         <1551183277.27819.66.camel@linux.ibm.com>
         <CAKv+Gu9H=yP8McwmsBP5nk-Fc3YHG2GF2zU+00gB4sqtfafyeg@mail.gmail.com>
         <1551189878.27819.86.camel@linux.ibm.com>
         <20190226180913.GA22368@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022619-0028-0000-0000-0000034D52C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022619-0029-0000-0000-0000240BA75C
Message-Id: <1551207911.3946.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=973 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-02-26 at 20:09 +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 26, 2019 at 09:04:38AM -0500, Mimi Zohar wrote:
> > Hi Ard, thank you for responding.  The clk not being initialized early
> > enough has been a problem for years.  Because of the clk not being
> > initialized, the TPM initialization is deferred, causing IMA to go
> > into TPM-bypass mode.
> 
> I'd guess this is an SPI issue and not really something that TPM could
> resolve? Please correct me if I'm wrong. I.e. SPI gets initialized after
> IMA.
> 

Peter's original post with some debugging is here:
https://lore.kernel.org/linux-integrity/trinity-3e6c2430-417d-4eef-b067-e30d68592b4d-1506716047790@3c-app-gmx-bs69/

