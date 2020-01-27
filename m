Return-Path: <SRS0=l+Hy=3Q=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57372C2D0DB
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jan 2020 17:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F78722527
	for <linux-integrity@archiver.kernel.org>; Mon, 27 Jan 2020 17:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0Ri4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:38:56 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgA0Ri4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:38:56 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 4497874854B043FFCECB;
        Mon, 27 Jan 2020 17:38:55 +0000 (GMT)
Received: from fraeml709-chm.china.huawei.com (10.206.15.37) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Jan 2020 17:38:55 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Jan 2020 18:38:54 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Mon, 27 Jan 2020 18:38:54 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Thread-Topic: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Thread-Index: AQHV1SsskZfHgOFdME+uHgUEG6qPTKf+xXdQ
Date:   Mon, 27 Jan 2020 17:38:54 +0000
Message-ID: <ca189378a5f841d0ba111c6405079569@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> owner@vger.kernel.org] On Behalf Of Mimi Zohar
> Sent: Monday, January 27, 2020 5:02 PM
> To: linux-integrity@vger.kernel.org
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> <James.Bottomley@HansenPartnership.com>; linux-
> kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> Subject: [PATCH 1/2] ima: use the IMA configured hash algo to calculate the
> boot aggregate

Hi Mimi

I did a similar change (patch 8/8) in the patch set I just sent. The patch is simpler,
as it reuses the data structures I introduced in the previous patches. Let me know
if I can keep this part in my patch set or I should remove it.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
