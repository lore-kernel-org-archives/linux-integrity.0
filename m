Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CDC169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A563A2177E
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 08:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+HF4WP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfA2IvZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:51:25 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:38206 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA2IvZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 03:51:25 -0500
Received: by mail-it1-f182.google.com with SMTP id z20so2984305itc.3
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jan 2019 00:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OSCh2/5feRAcBL8kC4kDWdFPCR/Kv1bBPzK1Zuya+s8=;
        b=k+HF4WP0mav5FKcvlhW6LGxdBCMtB5huEnJyhtxbybgVUHKzwjV/PYet/nF87/OfCj
         j8Lnb15n3jfh6KiZVCYS9sCK8E0AOusIkvI6hULG+ZDj0KlIqwJv+9H18Q7DiR+E46dl
         ltL6HxXgEkIEjrJTwBhNVapd/7kznpcarpUJ/DAnyf2Kt8a2MG1K1ZOYfoSkqI2UclsD
         4Nf9jqgcdP6FvqSDq+yJrXhacgIouDf/1U+iV1d/7r0tB7AaOMc8lx8z0SxY7YJzy4Nq
         sNNlcf/3C5gqPpQvNX0Q66ldQYRkes/e4phc2rF8E11N+0sQyuxy0SGWxfjbnP722Pan
         FlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OSCh2/5feRAcBL8kC4kDWdFPCR/Kv1bBPzK1Zuya+s8=;
        b=EiGAyk26iFcGK+hCtBsLRNTo8AKP1fxrvdi/PwT8Jmph9dE4Vnp3QK0X2V2+kWBlwW
         LciQ55x9NmBHvgeVEs+NkeZF2nCT3iGTuUUiDnxKF2oJLObqTq/A9ptd5u1trg8w/tAd
         myO6cqqso9vV1byhshV4lDqZtKCOHjRGJ4foybBpyYehf7VXIhSu5EZoN+rL5Ozmfkn5
         3TM27EubU6M4Qge8AAMcOx7jA5DpRIKVGg5u784XqslTuzxVPu6m05k9iCxofKIjOQKl
         J9mKc6s/K3Z4TZFeMTwWqpUl/YVVQeU2cffoyP7Jf95Hbnxe3+6F2G55UegvjSk9cO0n
         Vzjw==
X-Gm-Message-State: AJcUukc7MpzfcN+NyNqUfTFxAtnfj23Wv6rcIKcHt/xveeyc7rsLOnpa
        DtoEBiglCX62ZxxW3Uk5feqwUFHKIq57VlgumVO5e/0d
X-Google-Smtp-Source: AHgI3Ibv82lx5XqMITSrdQ5/nhrXWd7tnJHIKfSttzuCY6WnbV/S8QlGLHsQqaUQlYfm1gPR8ac8jh6DlDsRQtRg+Qg=
X-Received: by 2002:a24:648f:: with SMTP id t137mr11385466itc.176.1548751882756;
 Tue, 29 Jan 2019 00:51:22 -0800 (PST)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Tue, 29 Jan 2019 14:21:12 +0530
Message-ID: <CALUj-gsgpbcXD8xpG-XTZ3QCs_1CoN_9w6sOUSPVYHJ7OrnwQA@mail.gmail.com>
Subject: Understanding fsuuid policy rule for appraisal and exclusion
To:     linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Team,

I set the policy for IMA as follows. (1) Files in partition B will be
appraised or not if its UUID is not yyyy-yy-yy-yy. (2) Do files in
partition C only will be appraised irrespective of whatever rule is
written for other partitions.

My goal is to include a partition and exclude all other partitions.

# Exclude partition A
dont_measure fsuuid=xxxx-xx-xx-xx
dont_appraise fsuuid=xxxx-xx-xx-xx

# Exclude partition B (Problem here)
dont_measure fsuuid=yyyy-yy-yy-yy
dont_appraise fsuuid=yyyy-yy-yy-yy

# Appraise partition C
appraise fsuuid=zzzz-zz-zz-zz appraise_type=imasig

Regards,
Rishi
