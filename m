Return-Path: <SRS0=mqgK=SH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19BFC4360F
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B588420700
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXLc0ZrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDEMrI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:47:08 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38249 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfDEMrI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Apr 2019 08:47:08 -0400
Received: by mail-lf1-f51.google.com with SMTP id a6so4299486lfl.5
        for <linux-integrity@vger.kernel.org>; Fri, 05 Apr 2019 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D3A3OnIONtJ1Vea4H16i3y7KDaPSx1bBfWMELzX+hzg=;
        b=LXLc0ZrCfJXnPmUDJJKzuk6tqSluB+oJt38qvsOvRiV4AnKsIs251K9T/3pzicv8wH
         5QJmEnW0cyVzw9oQ8mTDxOzVxxxqqE02J6TJM9YcWCnvz9QfTXkVMM7aw1q8zSR0i062
         oXj1a/46QLpDUJrQa/7An5t/ART4859h5/7EPKmjj9Enf3JWHoGGzN1XYoHtiWGa/Tse
         hMAcmzQ85w/cx/z/cbGLxD8oUnobuph4MjrTAgGTqLt47eDH3DXowvOLHsoJVaDSRaNF
         Cw3EDrZyK6FRXW0MjjwFgB/3Y91ijTuWDCMXz6sDzJdj9TDCF1Ya//rYUiCKBtx2fJA6
         ADTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D3A3OnIONtJ1Vea4H16i3y7KDaPSx1bBfWMELzX+hzg=;
        b=eLHg5oxDJQCXJjhd0b+Ceh7N9y4ZNDacB751+52Bb2GmsAHzyIvEF5T5i+ux3hGdBD
         FDK7dJxL3FjeMngYUv1HTRXVSQXfMxU9jus9wGwBharJC439ivb4boa/6cwscbSqQmej
         RyBvyitQgNVDbHXAp7y1RXRbkRe+yRPLBibJdqQH7n8nbxsyaztNHmSw5paqULdM69Q4
         s7NMHVTHRy6MFuAZWWXvkc8V6L5NRe9A4azmN4W3uujrGb4WGtyAziYiqn19H7BMIknD
         JA2y2wctAbqSEr2ubDhVdh9s6ucBFWJ9ykIO4D0Mkd39ahHTM/RjMgTYmJdAWQOWeeYP
         HASg==
X-Gm-Message-State: APjAAAWjsRG/UfJO6OJR8DEewSMcgkFldXJhaztOU8p451aZlJTEEYCw
        wrMSKYG0BRqQexfRXj5XcuN+NJdXcQv7I437NDQW8Da8
X-Google-Smtp-Source: APXvYqz2CR52EH6MxL8VfUQ7JEgdGRl7dMcG+JpttuuvXFReC0HiRyW89tsbWboC2rHwRQkWqJkjwoGFCnB/uyaT3PI=
X-Received: by 2002:a19:7114:: with SMTP id m20mr6784829lfc.63.1554468425829;
 Fri, 05 Apr 2019 05:47:05 -0700 (PDT)
MIME-Version: 1.0
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Fri, 5 Apr 2019 15:46:54 +0300
Message-ID: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
Subject: appraisal reset safety
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I've setup an android based mobile device with pretty complete ima/evm
setup that covers just about all the standard use cases (imasig based
filesystems, ota support, factory reset support etc). All that is fine
and ima runs like a clock.

Since this is a mobile device, running out of battery or getting shot
in the head by something is always a realistic option. The random
resets seem to be leading into random appraisal failures as android
seems to be keeping surprisingly many files constantly open for
writing. So many actually, that I feel somewhat uneasy starting to
whitelist these files from the ima policy. That sounds like a viable
route only when it comes to the log files as those files primarily
move data only one way.

Now, is there any prior art on this how to make this work right? The
improvements that I can instantly think of are,
1) whitelist everything that can be,
2) reduce the vfs flush delays,
3) make it detect the reset condition and fix the known files when
that happened. Unsafe and requires a patch (but that seems easy).

Anything else?


--
Janne
