Return-Path: <SRS0=yQ5C=6V=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD12C47247
	for <linux-integrity@archiver.kernel.org>; Thu,  7 May 2020 07:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E995A2078C
	for <linux-integrity@archiver.kernel.org>; Thu,  7 May 2020 07:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDDTOKm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGHgB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 May 2020 03:36:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726579AbgEGHfz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 03:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588836953;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=vg3gAjb3Sk7KQVtWk6M+0e8g6+k5TaLScfnxont+BAw=;
        b=TDDTOKm0U4K+Rd4tuZbKKSRxjOeH8bFMSD78maemvClyGKcWqUfdxTU7YgKTMie3pKuBVJ
        Xmd6XPTan+KmGMcvVTQEhSqdHF8WmeA9znJJwfBUQ9TD757OjJ9WUQbjYO+7NfpP899ynS
        RcC9EcO49xwPvyYUBBT10kuo8Ln84Uc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-jJthUEciNVydfSUzNgEdVw-1; Thu, 07 May 2020 03:35:51 -0400
X-MC-Unique: jJthUEciNVydfSUzNgEdVw-1
Received: by mail-qk1-f198.google.com with SMTP id l4so4760953qke.2
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 00:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=vg3gAjb3Sk7KQVtWk6M+0e8g6+k5TaLScfnxont+BAw=;
        b=TtHd2TYO4YcrQyuMG3VC++bSQGd1IQwaQRvukzAxzNnV5RK9QtbyUBG/RzKlQN6aNe
         mnML/a1cRGb7M/vi8SNBIUlU0kt46y1Pd+v8jqjdPPeDRiSaMuUj2aoCgzYT72n81sWz
         JM9VFXCKJPvI2bosvlzA/GJhK/+4lbGZhE1HgsyYKxP4x4MoPdz69aA+2AsSFj/73Pku
         OBAJW88awJ5xgYbMCznLHtpZ96KnEzJAfXaz4mwqeFjLRacUYuCvphA92Ara6S9o4t6B
         YM1ofj2ScGhQ+L0WezLGAqfUGzIFTzIMOH3uJZtTpdqiS1ouRXRJA3z77tRc5qQhkjsA
         Dk1A==
X-Gm-Message-State: AGi0PubfeZGLtx6yEbioFL4EoijMbsQlRrRF0OnSO/Y1UxnCrIuXYpW0
        73xgzFZdudAHtITW0qzDsZrIqG7nPbKRfod9BrCMX9OJu5wg2oiRvfZln4XtONunFsuGr6qHyj1
        FE5fUWubLE5iAsIar8BIm+64MaKUz
X-Received: by 2002:ad4:4c03:: with SMTP id bz3mr12014981qvb.224.1588836950727;
        Thu, 07 May 2020 00:35:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypKsIDzKPVv/RmwQ/8PNSoblJXiXsLw/dYsVOYjxUx6G3cNhODMwrYk+IG49+IvlIerI67MsUw==
X-Received: by 2002:ad4:4c03:: with SMTP id bz3mr12014966qvb.224.1588836950439;
        Thu, 07 May 2020 00:35:50 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g16sm3580317qkk.122.2020.05.07.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:35:49 -0700 (PDT)
Date:   Thu, 7 May 2020 00:35:48 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: Disparity in tpm pcr5 value
Message-ID: <20200507073548.zpyv3u7rv3u7jqrs@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
 <4b3be2e9-35f7-d730-8e3b-b252ba5cb095@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <4b3be2e9-35f7-d730-8e3b-b252ba5cb095@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 06 20, Ken Goldman wrote:
>On 5/5/2020 6:27 PM, Jerry Snitselaar wrote:
>>On some systems we've had reports of the value of pcr5 doesn't match 
>>the digests in the tpm event log.
>>It looks like I'm able to reproduce here with 5.7-rc4 on a dell 
>>system using this parser:
>>
>>https://github.com/ValdikSS/binary_bios_measurements_parser
>>
>>Any thoughts on where to start digging? Is there another tool I 
>>should use to parse this?
>
>If you email me the event log in binary, I can run it through the IBM 
>calculator and see if I get the same error.
>
>

A couple other data points:

- On the Dell system where I did this if I change it in the bios to use sha256
   instead of sha1, then using tsseventextend to parse matches the value in the tpm.
   In the sha256 case there is a final events log.

- I have a nuc5 here, which also extends into sha1, and the parse matches there.

- Javier has also reproduced it when passing through swtpm to a vm.

- I added some debugging code, and there is nothing extending pcr5 with tpm_pcr_extend.

- Ken's parse of the log also shows the disparity, which I've now done as well with
   the tpm1.2 version of the tsseventextend tool.

