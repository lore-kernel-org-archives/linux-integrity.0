Return-Path: <SRS0=qoUO=3C=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1FC33CA9
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Jan 2020 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C775F2084D
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Jan 2020 21:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc01EN5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAMVZW (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:25:22 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40380 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMVZW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jan 2020 16:25:22 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so2999935vkh.7
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2020 13:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OpvaPhUxQK3b0285qLV51dH0ZUG+O4Xt8MnlA5zQeJQ=;
        b=jc01EN5gpMoiMi7OFwfxSu5JWDI/iFcYOpqOS9UXCoqrrapJhPRYzjrDmuANOumhTo
         bY1Hhh+hzP+LXapIgmH7TzK/hqv8HgTzCxjvw+S7wEhS6eBpHQC5Bo80cIly+76wRknU
         tcZtBDssz20+lwJVeWdf0jCFX3EwStfBdNJqhMWtmumv695KdYzu0XOVOoxYNSoMACF9
         YV8hGIWOcpTY4u4V/b+wqHL6qJge7yPeqFo1FJ7Sre+5MohWIbiRFJhwdOplHs6gZ0C5
         HTq1mgNNF1PkydPr02h0nkHTBTUsaeKAL2shIWhP2FfUaPIXo5thEJDaZX7Dq6qfVufv
         NO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OpvaPhUxQK3b0285qLV51dH0ZUG+O4Xt8MnlA5zQeJQ=;
        b=gX5Xsztm9P2QuO9GFglZoM61IZoOLtObasjM/HPTZgl4uxDx8wunCua9UgV+8xZ+ky
         q1u8EgW5FHhSsnvqyGbzskhew2b62APPSBKOBt/YHzoM6lT6BqiUoxf85FXMIudQQtUZ
         pfN6bzZDlKjY1bhIUmUoQqsCskY1wOcM2vxvhXMBH2rWQQR3FRm2r7ajZGT+CxL71z5d
         D/nQ/BRYKFq0VBWUxHfWhvYBVvU6WvMi6EQL9OLBFgHExTrVyjQEpD9q4ENUUaQ+xhxK
         TzSRfuAoh+SJav4BtVm0F1DWwwBo7X7jB3DjhMcZEHxnvi9vo8r0I9ZTIciHATGmlwvq
         ncDQ==
X-Gm-Message-State: APjAAAVNqZmOtq7PrlkQ35ZKT03++aVw8eCgsOeuUsaPUmMWhQkdrtCy
        KZpcoG1jIQa8fO/mmuSkR35oUe79AELwPhYYXGnFlTjZx+8=
X-Google-Smtp-Source: APXvYqyK8UWJPM7aOgijoc/inbAaUl4PmfrXGbu2CGwV3gyIQnymXFenvWsyQn+T/cqxQgN3NfIJvjYxozWwIFushvs=
X-Received: by 2002:a1f:8cd5:: with SMTP id o204mr11816651vkd.66.1578950721086;
 Mon, 13 Jan 2020 13:25:21 -0800 (PST)
MIME-Version: 1.0
From:   Andrea Bernabei <and.bernabei@gmail.com>
Date:   Mon, 13 Jan 2020 21:25:10 +0000
Message-ID: <CAJkYZaR1ECQax5M5CSWgfnbDMU2cZS=KKQZmTZtPhitAjj7bvg@mail.gmail.com>
Subject: TPM IRQ storm on Clevo PB50 (running v5.4.11)
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi everyone,

I am experiencing a TPM related issue on my Clevo PB50RF laptop.
There are about 40k-45k new tpm0 interrupts happening every second,
according to /proc/interrupts.

That does not noticeably affect the performance of the system, however
it is preventing the CPU power management from working properly,
keeping one core (the one receiving the interrupts) always at state C0.

This might be (the same or) related to the issue already reported by a
Thinkpad T490s user.

I am currently running Linux v5.4.11 from
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4.11/

The TPM device is a MSFT0101, part of PTT.

Is there anything I can do to help debugging the issue?

I have some (limited!) kernel development experience, so I will be happy to
contribute some time to debug or just test proposed fixes.

What is the current status?
Is there anything I could help with?

Regards,
Andrea
