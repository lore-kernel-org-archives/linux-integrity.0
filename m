Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E264C433DB
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Jan 2021 00:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2734B22CBE
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Jan 2021 00:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436957AbhAMAnF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Jan 2021 19:43:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47534 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392051AbhALX5z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 18:57:55 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0A6F320B6C40;
        Tue, 12 Jan 2021 15:57:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A6F320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610495834;
        bh=lNpe7IskQFEOmsakv8BU89HVRn5nxdxVcG55vHbn+cc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rqEoGW20UwyEYyxDHZ4mIRCbIHh5mYjn7ckY0kCItkg5Zl42CKhDLZjuWTnT2eIzG
         OPYCgGLX5pryjcgkzyqQPPteuJprA+iBUdHxqSrwc4xH9h7cM8roGYkHYDFTT+R2aa
         aeA18lIlbMBrekMV+jOZ2x+qkT7FB+ceNNHakBl4=
Subject: Re: [PATCH v14 4/6] powerpc: Delete unused functions
To:     Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210104192602.10131-5-nramas@linux.microsoft.com>
 <1f7db82ccf8e18306c9b51312b3e1f5d51f85cdb.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <05bb3c0b-2bd9-7353-d9a5-36d7a6e97f5c@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 15:57:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f7db82ccf8e18306c9b51312b3e1f5d51f85cdb.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/12/21 3:30 PM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Mon, 2021-01-04 at 11:26 -0800, Lakshmi Ramasubramanian wrote:
> 
>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>> index a05c19b3cc60..3cab318aa3b9 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>> +#include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/memblock.h>
>>   #include <linux/slab.h>
>> @@ -944,7 +945,8 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>   	struct crash_mem *umem = NULL, *rmem = NULL;
>>   	int i, nr_ranges, ret;
>>   
>> -	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
>> +	ret = of_kexec_setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,
>> +				     cmdline);
>>   	if (ret)
>>   		goto out;
>>   
> 
> The "powerpc: Move arch independent ima kexec functions to
> drivers/of/kexec.c" moved setup_ima_buffer() to
> of_kexec_setup_new_fdt().  Defering making the change from
> setup_new_fdt() to of_kexec_setup_new_fdt() here, is not bisect safe.
> 

Agreed - I will move this change to "powerpc: Move arch independent ima 
kexec functions to drivers/of/kexec.c" patch.

thanks,
  -lakshmi
