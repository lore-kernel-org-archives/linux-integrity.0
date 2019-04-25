Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45648C43218
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 21:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A42320685
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 21:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mu8sCk3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfDYVrj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:47:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37064 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfDYVrj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 17:47:39 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so2650669itc.2
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUZAqqVzdnJW/morQkX5GhLLofEUsN1mTNugt83lhoc=;
        b=Mu8sCk3VJNqdHZ1e3i0+egvQSZBXXlB/8O32ciXt84AB8vQiY0jrjOwggwv9cngmeA
         t8Cgg6WVdvlQB2yHe2i2LJfctz0s0Khik75YC++7aatBsfl+Uld2NKf9dVwPCQqd2t2q
         rnYacDyfiW6ZtqgPdI5it6/LSAFKWcJbHw7r2l8AERxcUYwUhgwnFIFf/AZjnZC+ZI5/
         dkkDNtGyDsyMuecdPT3NdeYrbJ4YDksRiomEu5LhjK/LvaGy6ThFy1gX9cUMC6NLXSNp
         Thm9GqZeod9tdQOUDK/9zOsLePirShMZ+4YTyt8wvbwCmclYIp9q5KrhAxiDzOw8cIJo
         28kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUZAqqVzdnJW/morQkX5GhLLofEUsN1mTNugt83lhoc=;
        b=J0UleO4gDlBGQep/IQLgFs2lq7VoKYG6vqjzWO3gg8mNe3gpiHL1xJB4isjEIuUgrS
         zDXIamUWrDc1O346kjACnLEFo7NPRB2Id50E3kuPsefQM59bTh36e8c71FM+z3GiqMEv
         NizrrDT/P3Z5rXJWMqPVVmnJYn0nxZItBnWOYkyKYFeikiRu9Uw7N3hnhSnVd3/wgpLh
         z5MnldKvgifls/jVtixEGxj4/ErrMUiMXBtP8sYG3zAe/ONZ47Z19wkSP4GvO2mcGG4W
         j68jxOE/nzR8SxluJKsrCaZBCQYcf1n4uSuLHdBb6oAfSzUMb0EHrG4kwW/CHl9EPC8Z
         evJw==
X-Gm-Message-State: APjAAAURLcefCxLS893KaJz5/FTHFmWFCT/HaJikUjXo5NyfYY2x6kGh
        ihgrPMH1LptEVGOKy/XtV5m7Fx3jE2DPcfpv+epQHsG44LA=
X-Google-Smtp-Source: APXvYqximb/JWMISl/acl6knvvYeGLQ4zoGp7l5VugXvX3RyAfehd4H4C9dkust56/0tO51h9CXkaqbwzhNb13tBfS4=
X-Received: by 2002:a24:a86:: with SMTP id 128mr5602553itw.118.1556228857960;
 Thu, 25 Apr 2019 14:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
In-Reply-To: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 25 Apr 2019 14:47:27 -0700
Message-ID: <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 24, 2019 at 11:30 AM 'Jordan' via mjg59 <mjg59@google.com> wrote:
> Under the following circumstances my kernel will not boot:

Will it boot under other circumstances (ie, if you disable Secure
Boot, does it work fine with the patches?)

> I have traced kernel boot to the call to efi_exit_boot_services in
> arch/x86/boot/compressed/eboot at which point execution terminates. I
> see Matthew has made a couple changes in efi_main which calls exit_boot
> (and in turn calls efi_exit_boot_services).

Does the boot hang or does the machine reboot?
