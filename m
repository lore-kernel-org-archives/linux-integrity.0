Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD4C282DB
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966620823
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 08:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAUIh7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:37:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33522 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbfAUIh7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 03:37:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so9495326plo.0
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jan 2019 00:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dsw1SL7jDPd/tJrerJXPR/p1xo0cmTUJIwt3NQ9thRs=;
        b=GrRikZ+ZvILmaTXpF09+P/4kDArzRoREExLtgo7/xi6QRgfRoddjeMhJqjj8+Icjkj
         eYdgYkW4bY+uslu8VmnBQJi5BKGtX1XtOGQMlRxOZnyCPBOjY+j1fVqEkMWdThjm8mRD
         Yo8I1YjYU0CWVpfMtLgSoDAbiIFO7wrnwzdD3WM6GoJcMjspTxkxMfSnzu5ss3n6p/b6
         NZxxNK2bKGNoEqcaUJ8c2e15bYfEi//8+exJgGhCwyD8uAdsh+iSNh60IMqKBUVwXB3t
         z9Q3CuwjrZw8Yfi1rr/thaYIhvz1T5O89d8iBVepVpMiEhYI1vZzjch5dAgwXa6wjNzK
         laiQ==
X-Gm-Message-State: AJcUukf8GsYs6hmoaNXYS/vIXvgi/xxtGgCifsVQqGrvM/5D8YEVJ5jz
        33nchL8Sn8x8pXTTuoJWPt2hAWdGBCE=
X-Google-Smtp-Source: ALg8bN7V9CalXJRFrfqtdOIdy93+IBptgyQeNHlj5SWLZfzyPIw3L0q+z74KDnOQwKKqQ5scaBZffw==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr27904046pls.12.1548019814217;
        Sun, 20 Jan 2019 13:30:14 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id t67sm20108746pfd.90.2019.01.20.13.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 13:30:13 -0800 (PST)
Date:   Sun, 20 Jan 2019 14:30:12 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH REVIEW 2/2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190120213012.w2iyc26dcjk53g42@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20181214132115.26223-1-aklimov@redhat.com>
 <20181214132115.26223-2-aklimov@redhat.com>
 <20190103131453.GC10491@linux.intel.com>
 <20190114193940.mylziev4xhidmazs@cantor>
 <20190118145930.GE4080@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190118145930.GE4080@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jan 18 19, Jarkko Sakkinen wrote:
>On Mon, Jan 14, 2019 at 12:39:40PM -0700, Jerry Snitselaar wrote:
>> Alexey was following the example of tpm_tis_update_timeouts() which
>> returns true if the timeouts were updated, and otherwise returns
>> false. The bool here makes sense to me, but what rc would you suggest
>> in this case?
>
>Maybe the pattern used there is not that great then.
>
>The callback should simply be update_durations(chip), and it would do
>whatever updates needed and either return zero or -errno. And of course
>update durations_adjusted flag because that is needed in sysfs.
>
>/Jarkko

Taking a quick look, they already track whether the adjustment
occurred in the tpm_chip struct, so that could be used instead for
what the bool return was being used for. I'll post a patch for the
timeout updates code, and work with Alexey to rework his patchset.

Regards,
Jerry
