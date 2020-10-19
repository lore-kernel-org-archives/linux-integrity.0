Return-Path: <SRS0=Eeq+=D2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E2C433DF
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Oct 2020 20:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32BA223C7
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Oct 2020 20:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y8cyR7Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJSUIy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:08:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSUIy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 16:08:54 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id DFAD820B4905;
        Mon, 19 Oct 2020 13:08:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFAD820B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603138134;
        bh=FStZSKGlPhQcQNaAh/Qw7cCooDAxWHQ44TE6t+RUMGU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Y8cyR7Orkw5Uh8sIytCpOaAwTRWI+/r18Rb058qQV+MutG2ep3bOebx1AFXv22SV5
         VJYjyUKA7aLIWUHUvXh0PdxzwjBeZew0lan/CMteMTz7ubg0MT0tYSVOr/kwQkTCqE
         MDlxfLBeEllLTPJj8fMIAZYtyBULxntPALMA1peg=
Subject: Re: [ima-evm-utils][PATCH] file2bin: Pass the right values to size
 and count parameters for fread()
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
References: <20201019200526.12678-1-nramas@linux.microsoft.com>
Message-ID: <f5a142d8-0d98-7697-6ed8-f713d09715da@linux.microsoft.com>
Date:   Mon, 19 Oct 2020 13:08:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019200526.12678-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/19/20 1:05 PM, Lakshmi Ramasubramanian wrote:
> The 2nd parameter to fread() namely "size" specifies the size, in
> bytes of each element to be read, and the 3rd parameter namely "count"
> specifies the number of elements, each one with a size of "size" bytes.
> 
>   size_t fread ( void * ptr, size_t size, size_t count, FILE * stream );
> 
> But in the function file2bin() the values passed to "size" and "count"
> are reversed causing the function to return an error eventhough the file
> was sucdessfully read.
> 
> Pass the right values to "size" and "count" parameters for fread() in
> the function file2bin().
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>   src/evmctl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7ad1150..d49988e 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -221,7 +221,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
>   		fclose(fp);
>   		return NULL;
>   	}
> -	if (fread(data, len, 1, fp) != len) {
> +
> +	if (fread(data, 1, len, fp) != len) {
>   		log_err("Failed to fread %zu bytes: %s\n", len, name);
>   		fclose(fp);
>   		free(data);
> 

The above patch is for ima-evm-utils. Missed adding "[ima-evm-utils]" in 
the subject.

thanks,
  -lakshmi

