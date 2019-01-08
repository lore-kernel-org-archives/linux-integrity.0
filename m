Return-Path: <SRS0=75dh=PQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7CC43387
	for <linux-integrity@archiver.kernel.org>; Tue,  8 Jan 2019 01:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1FE20663
	for <linux-integrity@archiver.kernel.org>; Tue,  8 Jan 2019 01:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT1WmdkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfAHB0t (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:26:49 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46211 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfAHB0s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Jan 2019 20:26:48 -0500
Received: by mail-io1-f54.google.com with SMTP id v10so1894278ios.13
        for <linux-integrity@vger.kernel.org>; Mon, 07 Jan 2019 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ugpry2LNY7xcO+Z0JGr+deZ8vam5RMCyGxU/dAebrtU=;
        b=jT1WmdkMvxd6y+HDmQvG26bgwutGPROf7Gc0ZoNaK1Hrwu/JklN30xYxJHUe6Qxk6w
         V/BcDzzQrkqWecdO3o+F5syFMCmrqhHinFxZ/aLDzEPomWjdJm+pY2I60taTl1ATVLQc
         eiHFo6Gy5/T89VwmZZfjnObiUCzGrtHReDIn38XO++siowXNwJfIzsHbaJCV5VG0uvH7
         Ma8xdUn5iJqIjYDhGjL5oJF5PYviB0jDj4K+zBURzf8Z9/5MhXMS/sOEYzvTsDj1836I
         vA+Im88vH6Dr/RqQNDBJ1MNMtT2w41ekWLjPNnqWzhejmgxsIEkVUmJqygqbVa/GYJbr
         g52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ugpry2LNY7xcO+Z0JGr+deZ8vam5RMCyGxU/dAebrtU=;
        b=fBnAwYARDFC2fpkMDoUN5PwGdxo5RP1x4fGe0wAF3nQ871UhMlOWauZNjQowIpcEjy
         3ob0vWHCAeG4r7yEUeeUBEoWszwE9nTeqTkoQ82eaCifvcLVCUrd/Jc+W1FXqgCgEzmc
         FLVFzQjcngb3wEDtHNrkrwwUn3ReVgpiJMZ4WdDBS4cYE9YP49Aq06dX3aje5dyQCPaX
         A0oxpjS1RkmPqltQoTykCEWE8lMsLQGttykB14igWkQv5elZIHcEo+TgQcnST2ru45fj
         huQ8donLLKkVLgX3nZvnWzfUCouHfAMUw6IkSK0vimrdaEi8CgbEWJGQruEGO+00RNKp
         +C2w==
X-Gm-Message-State: AJcUukdZZcH9iacXE3E4rz7J+nhmkFBrTVAMQsi9CaZrRnaFmgdvH0rL
        8/APT90PVszwV+O1Wk1a+OgSKRy64s7wcFKg3geCBcMB
X-Google-Smtp-Source: ALg8bN65KmNk7N7eh2EpQZcAcZSXEFQybaK3Ww+/wkWpbulN9JaOL4peIb4MOEfFI1mRnhirOKSXfCWXWIbZlKk4Uuw=
X-Received: by 2002:a6b:7e04:: with SMTP id i4mr23129907iom.116.1546910808045;
 Mon, 07 Jan 2019 17:26:48 -0800 (PST)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Tue, 8 Jan 2019 06:56:37 +0530
Message-ID: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
Subject: OTA does not work with IMA due to xattr not supported by zip
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Team,

Android and android recovery based implementation for Linux, generates
ota package which is a zipped archive.

I observed that xattr gets dropped when creating zip archive and
therefore after OTA system will not boot if IMA_APPRAISE_SIGNED_INIT
is used.

This essentially means that IMA may not be used in commercial products
requiring OTA or I missed something or there is a workaround to such
problem.

https://source.android.com/devices/tech/ota/tools

Regards,
Rishi
