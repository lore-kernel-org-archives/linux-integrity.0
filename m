Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:16824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbeAEOzV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jan 2018 09:55:21 -0500
Subject: Re: [GIT PULL] linux-integrity patches for 4.16-security-next-general
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>
CC: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <1515159816.4418.7.camel@linux.vnet.ibm.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <4806797a-bb15-6996-6654-7e21d39b7699@huawei.com>
Date: Fri, 5 Jan 2018 15:55:16 +0100
MIME-Version: 1.0
In-Reply-To: <1515159816.4418.7.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 1/5/2018 2:43 PM, Mimi Zohar wrote:
> Hi James,
> 
> Mimi Zohar (2):
>        ima: relax requiring a file signature for new files with zero length
>        ima: support new "hash" and "dont_hash" policy actions
Hi Mimi

I think there is an issue in the patch above.

+	/* HASH just sets the digital signature flag, nothing else */
+	if ((action & IMA_HASH) && !(iint->flags & IMA_DIGSIG)) {

IMA_DIGSIG now is an atomic flag.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
