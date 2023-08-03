Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E0C001DF
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Aug 2023 19:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjHCTa2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Aug 2023 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHCTa1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 15:30:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FAA91BF9
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 12:30:22 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 58E9A207F594;
        Thu,  3 Aug 2023 12:30:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58E9A207F594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691091021;
        bh=TKSKfqlVS6X4NQLJSx6LD4t4ILTBcwpO2TA3mdti8zY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TJa7+o0FiIKVVPzEyvc8YOgLBAortchjyrMZXATUI8sdXSO35hqiwGrrZy2mFOD/W
         ZXj7AyuztmuJGP/x+xf6D5+eklbKi975XllNOuXXXSRVGK0QegEFROzR9B8Q+mvgLL
         +vBGWUj8ZffKQ5m/PGiYd6zV5l0HZbXtAq+hAPYk=
Message-ID: <7913a162-3da3-61b4-49ce-8e762da47966@linux.microsoft.com>
Date:   Thu, 3 Aug 2023 12:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, ebiederm@xmission.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
 <CUIRWHEMXL38.29Z2XR564KV33@suppilovahvero>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUIRWHEMXL38.29Z2XR564KV33@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/3/23 01:43, Jarkko Sakkinen wrote:
> On Thu Aug 3, 2023 at 12:04 AM EEST, Tushar Sugandhi wrote:
>> Btw, the function tpm2_pcr_read is not exposed directly to the other
>> subsystems (like IMA).  It is exposed via tpm_pcr_read.
>>
>> Do you want to expose tpm2_pcr_read directly,
>> or do you want me to update the function signature of tpm_pcr_read as well?
> As long as you mention that 'update_cnt' causes divegence in the
> in-kernel API, and therefore tpm[12]_pcr_read() cannnot be under the
> same orchestrator.
Yup. I will mention that in the description/comment.
>
> If you take this path, please implement a precursory patch, which
> replace the existing call sites with some sequence of tpm[12]_pcr_read()
> and tpm_is_tpm2() calls.
Sure.  I will add a precursory patch which will replace the existing
call sites.

Thanks for confirming the approach.

~Tushar
> BR, Jarkko
