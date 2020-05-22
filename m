Return-Path: <SRS0=IAFg=7E=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE4C433E1
	for <linux-integrity@archiver.kernel.org>; Fri, 22 May 2020 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C1C207CB
	for <linux-integrity@archiver.kernel.org>; Fri, 22 May 2020 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590175409;
	bh=bXZEeDnqQ8pc/bjS8vchYZuh+kFAQrGp2mx12nXsRPg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bSFEql+vZWZURncpO1InjLkBcO8hbSNyM0ReOx8NMSt9S4KHSlCygLcZtqmEbMyFs
	 rlSVygt0/VkxASPci6pRaQ5F6b78+KDMHsG+opAFjfTr27fE4hcODTnM50lp/CLnyM
	 9SZPDfpk4LSfEkfbu0/Sq9mTRMPJAMA4sLyf2pw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgEVTX2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 May 2020 15:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730689AbgEVTX2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 15:23:28 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66765206D5;
        Fri, 22 May 2020 19:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590175408;
        bh=bXZEeDnqQ8pc/bjS8vchYZuh+kFAQrGp2mx12nXsRPg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Dsp9uIUWGqanhKiv6bL7aBsBy9OdouDgDo2Rzvz4C1nxxf2B3+ZuHtzjMZHbXQ0RP
         OvGJV+LOZ3fL+mtlJEE1SsVFUACWpds3uCr454Rd0ngh+hog81q5VtB48LAGIYYhZI
         xXlIsxt84hAOIbTfweLYuOgaJb6D+LQVVDNPkpfE=
Subject: Re: [PATCH v3] Kernel selftests: Add check if TPM devices are
 supported
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Cc:     linux-kselftest@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org, shuah <shuah@kernel.org>
References: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
 <20200522163714.GA10319@linux.intel.com>
 <20200522163745.GB10319@linux.intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b433d7c7-38a2-098a-55c9-6f8cc13f7230@kernel.org>
Date:   Fri, 22 May 2020 13:23:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522163745.GB10319@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/22/20 10:37 AM, Jarkko Sakkinen wrote:
> On Fri, May 22, 2020 at 07:37:17PM +0300, Jarkko Sakkinen wrote:
>> On Thu, May 21, 2020 at 05:43:44PM +0300, Nikita Sobolev wrote:
>>> TPM2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
>>> are available. In case, when these devices are not available test
>>> fails, but expected behaviour is skipped test.
>>>
>>> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Shuah, can you pick this up?
> 
> /Jarkko
> 

Done. Applied to linux-kselftest next for Linux 5.8-rc1.

thanks,
-- Shuah
