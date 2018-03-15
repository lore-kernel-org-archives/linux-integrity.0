Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751546AbeCOVBs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 17:01:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2FKtXuG168345
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 17:01:48 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gqyehaqnd-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 17:01:48 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 15 Mar 2018 21:01:46 -0000
Subject: Re: [PATCH 0/4] Code improvements in integrity and IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 15 Mar 2018 17:01:40 -0400
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521147700.3547.662.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Thiago,

On Wed, 2018-03-14 at 17:20 -0300, Thiago Jung Bauermann wrote:
> Hello,
> 
> These patches come from the "appended signatures support for IMA appraisal"
> series. They are code improvements and cleanups and I decided to submit
> them separately for a couple of reasons:
> 
> 1. they stand on their own and could be included in v4.17;
> 
> 2. this will simplify the original patch series a bit, by having it contain
>    only the patches actually necessary to implement the feature.

Agreed.  The first 3 patches are applied.  The last one, we'll see
about.

Mimi


> 
> These are the changes made to them since v5 of the modsig series:
> 
> - Patch "integrity: Remove unused macro IMA_ACTION_RULE_FLAGS"
>   - New patch.
> 
> - Patch "ima: Improvements in ima_appraise_measurement()"
>   - Moved is_ima_sig() to its own patch (not in this series).
> 
> Mimi Zohar (1):
>   ima: Improvements in ima_appraise_measurement()
> 
> Thiago Jung Bauermann (3):
>   integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
>   ima: Simplify ima_eventsig_init()
>   integrity: Introduce struct evm_xattr
> 
>  security/integrity/evm/evm_crypto.c       |  4 ++--
>  security/integrity/evm/evm_main.c         | 10 ++++----
>  security/integrity/ima/ima_appraise.c     | 40 ++++++++++++++++++-------------
>  security/integrity/ima/ima_template_lib.c | 11 +++------
>  security/integrity/integrity.h            |  6 ++++-
>  5 files changed, 39 insertions(+), 32 deletions(-)
> 
