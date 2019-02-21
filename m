Return-Path: <SRS0=/8cw=Q4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F6C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8AA20855
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfBUMti (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:49:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUMti (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Feb 2019 07:49:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LCn36r001678
        for <linux-integrity@vger.kernel.org>; Thu, 21 Feb 2019 07:49:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsuv4s8rh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 21 Feb 2019 07:49:36 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 21 Feb 2019 12:49:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 12:49:30 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LCnTmp27197632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 12:49:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7598242049;
        Thu, 21 Feb 2019 12:49:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC654203F;
        Thu, 21 Feb 2019 12:49:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.92.188])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 12:49:28 +0000 (GMT)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Markku Savela <msa@moth.iki.fi>, linux-integrity@vger.kernel.org
Cc:     Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Date:   Thu, 21 Feb 2019 07:49:18 -0500
In-Reply-To: <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
         <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
         <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
         <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022112-0012-0000-0000-000002F87615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022112-0013-0000-0000-000021300BD2
Message-Id: <1550753358.17768.85.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210095
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[ Cc'ing Peter ]

On Thu, 2019-02-21 at 11:08 +0200, Markku Savela wrote:
> On 20/02/2019 10:14, Markku Savela wrote:
> > No hints how to solve? Anybody?
> 
> I changed IMA to just ignore the tpm test in hope that TPM would be 
> ready by the time IMA needs it -- no such luck, the "tpm2_probe", which 
> triggers the manual start just comes too late. I could just force the 
> manual startup earlier in boot, if I could figure out a proper place to 
> put the function call...
> 
> 
> [    4.008322] ima: Allocated hash algorithm: sha1
> [    4.012820] ima: Error Communicating to TPM chip
> [    4.017302] ima: Error Communicating to TPM chip
> [    4.021763] ima: Error Communicating to TPM chip
> [    4.026004] ima: Error Communicating to TPM chip
> [    4.030295] ima: Error Communicating to TPM chip
> [    4.034558] ima: Error Communicating to TPM chip
> [    4.038766] ima: Error Communicating to TPM chip
> [    4.042805] ima: Error Communicating to TPM chip
> [    4.046951] ima: Error Communicating to TPM chip, result: -19
> [    4.059431] uart-pl011 3f201000.serial: cts_event_workaround enabled
> [    4.063766] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 72, 
> base_baud = 0) is a PL011 rev2
> [    4.069963] console [ttyS0] disabled
> [    4.074178] 3f215040.serial: ttyS0 at MMIO 0x0 (irq = 151, base_baud 
> = 31250000) is a 16550
> [    5.282479] console [ttyS0] enabled
> [    5.293360] Indeed it is in host mode hprt0 = 00021501
> [    5.308808] tpm2_probe cmd rc=256
> [    5.322282] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> [    5.358842] tpm tpm0: A TPM error (256) occurred continue selftest
> [    5.378137] tpm tpm0: starting up the TPM manually
> 
> 
> Earlier in boot there this "spi-bcm2835" notice. Is this the reason the 
> probe gets delayed?
> 
> [    3.440240] Loading iSCSI transport class v2.0-870.
> [    3.442267] spi-bcm2835 3f204000.spi: could not get clk: -517
> [    3.442804] libphy: Fixed MDIO Bus: probed
> [    3.443019] usbcore: registered new interface driver lan78xx
> [
> 

This problem was previously discussed here -
https://lore.kernel.org/linux-integrity/trinity-3e6c2430-417d-4eef-b06
7-e30d68592b4d-1506716047790@3c-app-gmx-bs69/

Mimi


