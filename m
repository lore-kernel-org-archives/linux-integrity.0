Return-Path: <SRS0=wcDA=23=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6CBC33C9A
	for <linux-integrity@archiver.kernel.org>; Mon,  6 Jan 2020 03:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3FC21775
	for <linux-integrity@archiver.kernel.org>; Mon,  6 Jan 2020 03:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aGTbmBWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgAFD6j (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:58:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50616 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAFD6i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jan 2020 22:58:38 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 069592007679;
        Sun,  5 Jan 2020 19:58:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 069592007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578283118;
        bh=TJ/xo/K68F6Ht7hyWkjFJEA7cR0KhXf/wkwgg9clTHE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aGTbmBWwalTBMswQgOMS6OWadInXstYtbpVhpwbpFEe7VfmEfaj/gFGKhC80X3YpG
         jIMmcDcJPGiIbPreE+dGk2/wj2SAphJCMqvG1ZweJW4ESRHH6fXzTXzR1mUrXfFLTz
         rsG9jJ1xNSjQBY3KDgscGZBPfBOMIJTJSlN1P3vo=
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
References: <202001051708.DO90I9sl%lkp@intel.com>
 <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
 <1578248115.3310.41.camel@HansenPartnership.com>
 <2a24e191-fc31-a502-7463-b6e90f91e1c5@linux.microsoft.com>
 <1578251768.3310.49.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <dd99db8f-08de-d7ac-3d63-0717fc6c7ba5@linux.microsoft.com>
Date:   Sun, 5 Jan 2020 19:58:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578251768.3310.49.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/5/20 11:16 AM, James Bottomley wrote:

> Well, yes, you just need to condition the build of ima_asymmetric_keys
> on a boolean instead of a tristate, so you introduce an intermediate
> one:
> 
> config IMA_ASYMMETRIC_KEYS
> 	bool
> 	default y
> 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> 
> James

Thanks for your help James.

Hi Mimi,

I have defined a new config as James has suggested above and verified 
the kernel builds fine with the ".config" files given by
"kbuild test robot <lkp@intel.com>".

Would it be possible to share all the ".config" files that
"kbuild test robot" would build with? I'll make sure my changes build 
fine with all those.

thanks,
  -lakshmi
