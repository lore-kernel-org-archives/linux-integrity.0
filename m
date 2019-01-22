Return-Path: <SRS0=iyby=P6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D17C282C3
	for <linux-integrity@archiver.kernel.org>; Tue, 22 Jan 2019 20:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180FF217D6
	for <linux-integrity@archiver.kernel.org>; Tue, 22 Jan 2019 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfAVUWC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:22:02 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39052 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVUWB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jan 2019 15:22:01 -0500
Received: by mail-qt1-f176.google.com with SMTP id u47so29158435qtj.6
        for <linux-integrity@vger.kernel.org>; Tue, 22 Jan 2019 12:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=FkwHfMiH5baHUV5NkS37/hCcEw//A2JchphI5XNWSgQ=;
        b=g80+mmV/WhfBlFB+nY47WlzuY3d0M6Srrq0Pi3g5su6hvCt7+vGJhMLQLqOSNldhth
         r/DtRi91VL21CYFsFKpXy8K1xT0b2kafASkjbXvhJDYXQcDQsdykXFgSK0TZX89t61vp
         or1RmWKCsjeBjDGthtKtiAUpne3zjN2kiQ5aBCH/AAarrJ3B0SLhswd7p26AwdC5jtQa
         q01Z37Ckv5tohpcw09ATIEcBWS7E5kRbgLyaO2BbnKIk8dysDJ0hM/NKNsp7Af7iUr5X
         2xgq0PHo7IHUHWzV42KcsXBCQSbCvneUw2TwLsglPYI7U/FcElhGRskz3WazmC/lDFMN
         /egg==
X-Gm-Message-State: AJcUukePIHlFknH6VkrIiNTOLuUGw5lBTmpdt3uvzCyc8yC4qzMuoHD/
        D/9n6aFN2ABqEBuV3xvOwZWkU3hjs0M=
X-Google-Smtp-Source: ALg8bN6d2/o49R9vlz2Ckuzz1AdhjxBILlSY93hiyiNcdjqgfSzOeVQoFSP7v4pDv0DZsdcBV0VccA==
X-Received: by 2002:aed:2c22:: with SMTP id f31mr33637265qtd.154.1548188521077;
        Tue, 22 Jan 2019 12:22:01 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id t43sm97566955qtc.53.2019.01.22.12.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:22:00 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:21:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: TPM2_RC_TESTING and tpm_transmit_cmd
Message-ID: <20190122202159.ktlrxewwr7vryayc@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Would it make sense to filter out TPM2_RC_TESTING when reporting an error
in tpm_transmit_cmd, or possibly spitting out a follow on message in
the selftest code that the tpm is still testing?

Had a bz opened here because someone had the error message in their logs,
and I can see how it would be confusing. We have the intermittent selftest
patch already so it should be functioning, but just wondering if not
printing out that error message would make sense.

Regards,
Jerry
