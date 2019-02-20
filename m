Return-Path: <SRS0=IP2B=Q3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5293BC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Feb 2019 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A4920859
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Feb 2019 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jo6ra5sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfBTT2Z (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:28:25 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:50493 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTT2Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Feb 2019 14:28:25 -0500
Received: by mail-it1-f172.google.com with SMTP id m137so18138522ita.0
        for <linux-integrity@vger.kernel.org>; Wed, 20 Feb 2019 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAQjYpxURrhpogN/Esh+ZqZVXSNEREIALD+GbHy6H3Y=;
        b=Jo6ra5sl1T1Qz/eiBwRpze/dFsc+4uxGtOdD4KoLCMvFCL2+FhIKPe1L/vnU4cLX3R
         45xAgsCk0yPAC+5QJGSWb0Yy9tazlOITYlDUA5BBoy8PkZGwMdkJpVUq5/wwcZphoC3E
         a+Ex6r7Jw6nvFHpQm1/YBtdL40aESJEczJdPVh3Q1Fg7B7w3V/zGGpMTS9O9qdct/mgd
         tIrJ62eZzS7+uVDtPpIgEISGB2vYPnyjd5Pxs1qKf6DEKqJGxZBrcDdXmuTRCYDFpgiY
         gE04JIoh5jEbzHViU/6uQQlcZo03oeVX5Dcknv5ML+I02SnCcbk+ainZzmultBl/+GSJ
         iL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAQjYpxURrhpogN/Esh+ZqZVXSNEREIALD+GbHy6H3Y=;
        b=C4VXXZbHTJEB7WILQSc2TZ02SFyEanhZlFXHqhF+2RK9RwbYFaNLL/ojd2U13Jk4J1
         EUKtZV7JdGXSUmBtCZDXl+nFFwt2nlzMX9C7IFaayMBhy+PHCWjtDLV2wi9gP2j6Gypz
         jEQTwnkZgcnhPIbpProyFF5Hj3Gy3G4n0N+Olbz1ZnpHO1PHE/T+dGEs3rKO5kQjyl5x
         F4BclPH/AKdXpImnqMcS4VwlXh4Ht6lKxP+8Cxagf3OXvbfcyjWb+tF/ES11bH3uDjIP
         c2iy9wWCCquO8L9KbffTCzVh5BdNSAEY6V0lFw0wxTW8IZzFKV1buB40XXUdwqyLhi2T
         MCXg==
X-Gm-Message-State: AHQUAuYwBMI6gqQ7z68ohcIlVdjyupV+xQHZCkdyJhx5MzT2q1muuyIc
        XDTrdvCW8TtvKFngljNvjNKl5+N4sVIhg2oJ0j0DWhl6
X-Google-Smtp-Source: AHgI3IYeNBlyukq3QXtdVRz9fXYMDWJ4lIEy4rE3ngo+05ZGi0YehGrY1qqVVXRigKSTDOyGn62rS3tvNZmFSoNdzU4=
X-Received: by 2002:a02:240d:: with SMTP id f13mr20354908jaa.105.1550690904590;
 Wed, 20 Feb 2019 11:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20190211215518.81419-1-matthewgarrett@google.com> <20190219115652.GA29454@linux.intel.com>
In-Reply-To: <20190219115652.GA29454@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 20 Feb 2019 11:28:13 -0800
Message-ID: <CACdnJus0nkTtYyVsb71_nN11Oazj2xyR8WoMs6+r+jN=RYos8g@mail.gmail.com>
Subject: Re: [PATCH V3] Add support for TPM2 event logs on EFI systems
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 19, 2019 at 3:56 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> Tried to test with a Geminilake NUC but for some reason do not see the log
> file with this machine.

I'll retest a rebased tree on my NUC on Friday - just ran out of time
to get a build done before I had to leave for a trip.
