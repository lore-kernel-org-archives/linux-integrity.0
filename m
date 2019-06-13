Return-Path: <SRS0=4zez=UM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB7BC31E45
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Jun 2019 23:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F82320896
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Jun 2019 23:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AjDLlpwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfFMX0Q (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:26:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36911 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfFMX0Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 19:26:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so448627qtk.4
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F+ZNNkU42Zd6MKvCjZT6fZTudYGwmy2RKo0LgzcVRSU=;
        b=AjDLlpwmNfzoZ3a+L0pKpghn4C5KkwKVJhZ1zpGZH4YRef546YsvXQeegAaUOJiQ4Y
         EkUHkw+kuMW8NCJYYwOPRTMc531YMSk+0JHhUv5uB7hussU1rnPJkrReZJcsOl6uxivE
         1ubH7ByO3aIRqk6FIKNEkGtmCo7RSIATaONs+bqvXGbFHQxP5PiAE+idq1/HaJn3VhpO
         jH3pPSYX+K9RYL+lP5v9NAfetb7zLERYuHnGGnPQRWz/FXdJ9HcNJmt7R7ZB0Oe+4ngb
         eKRI119lOCP64fDy7SfKWm4vtn6ZrAFZUdAV6Q/bWDU4P3Dbv9NqcMhW8ps0m9Ql/owS
         94PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+ZNNkU42Zd6MKvCjZT6fZTudYGwmy2RKo0LgzcVRSU=;
        b=aeq8n6SyJ+1T017cYZeiCLr4Q33vw5iba9m0W+v4Co3eH/4C4e8hwuOKbfT2sbFRV3
         /BpNXq5UGzVd+p4KCI4FhPPixyHbz1n0Di0O9HaLuSQY+nAuQ0NP3NTXB/Vb9m5om/rx
         GcUw4zrQy4DgmYEgj33zqUZp9VajWLfLIyJS/IUb0XSz7WKS5YLs5vgTTgM/FIJs5v3G
         zMDmSwpRKQ1qAzz6BkOTxSV8/g1WXkcKkrjftUCNhiZz2wUaEfJQg94qHJSnWXnljncp
         zqpnjnyDZKpBhxJ0/v5VNCpBeN+kyV5Y31A//2qAmB7G9gKWiaPbSDXBle899teGAlAH
         sYZA==
X-Gm-Message-State: APjAAAVVraMlxd5HGaccRhbe4I19CwF7U7eXmejDLTs0vMpNhIVPucw2
        VYi4D2WtVTrfIMENSL9pOKcY97b9s5wbow==
X-Google-Smtp-Source: APXvYqzWriKVUDZ5RTX5KYjr8TMROH1C4/qZXtl38Ut2dLWUQfovUnmMtQwIEJSQL8gvZ8G5onWSxg==
X-Received: by 2002:a0c:981b:: with SMTP id c27mr5622812qvd.48.1560468374799;
        Thu, 13 Jun 2019 16:26:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o185sm565691qkd.64.2019.06.13.16.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:26:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZ6j-00011c-BZ; Thu, 13 Jun 2019 20:26:13 -0300
Date:   Thu, 13 Jun 2019 20:26:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Message-ID: <20190613232613.GH22901@ziepe.ca>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613180931.65445-2-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Other drivers or userspace may initiate sending a message to the tpm
> while the device itself and the controller of the bus it is on are
> suspended. That may break the bus driver logic.
> Block sending messages while the device is suspended.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
> I don't think this was ever posted before.

Use a real lock.

Jason
