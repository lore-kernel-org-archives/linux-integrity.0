Return-Path: <SRS0=uMbN=OQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167FC04EB8
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Dec 2018 00:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2359520700
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Dec 2018 00:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnCDbvDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2359520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLGAA0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:00:26 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:54494 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeLGAA0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Dec 2018 19:00:26 -0500
Received: by mail-it1-f182.google.com with SMTP id i145so4317648ita.4
        for <linux-integrity@vger.kernel.org>; Thu, 06 Dec 2018 16:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoFWjeepUpoCvO4xTb0Gn494hlZpYiOLnR/OC6FuKMc=;
        b=qnCDbvDIQerdLreuAIgo5+lLQpqOp+jdN+YuO0eBAomqkSOwuUkBJZTODMqxT12P05
         InMEpHH6DhWYS9E/2RfBJ1/rpuMCjDWzvth0fPyVVimp50wRZBAh1oyNrIhbt/ZeFUmj
         FbtklN07koFTevyElw+rIvKlcxVWrGPDFVTjMnsRR0bSLlyNIzf0MYWlxevgLcpRROKi
         Sx15cwdpP8YQ6NYTu3cEHaAJ6uvsw1PAUA6ZQAwT3rFfA5BCHtIuzePQ5sMtTc1cKEmi
         1lnS7VwxgrevyiFdBuAYu7Ul4jATs31eSTmCISx9HoU5GyLGSisivpsDyt9mq/1HUoQD
         Jhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoFWjeepUpoCvO4xTb0Gn494hlZpYiOLnR/OC6FuKMc=;
        b=NuYu2HYzKdv/VUurSRUsHpsrBAc5e7uE/s+svQdtt1i0pAvv0vPbA5RVbdwnKWHxhH
         brFh05Bi5Ie2ny4+AMDrXnEn3mLQS8iVOdowELd6KJJOXhOnnDIqm5QK66+n3viNrS/n
         iMRXn09HEsutqDnQGr83b6JmOgGKZmHWyDiurUUoVv8Cit3o4ofDuVHvNByqgc3WQl6x
         LfN3sJRy4t861gONEiMnj4tUJ4/hN4J62MsAvA9gOjgYhDuyfY9nYYPSyb8WQACB6xPk
         yZfv6AuyjL0ZqTol9E8o9WQFtySPabj8n91+cOC1oECdZxDBm74BhglvMNqgh0yxO6z3
         MWIQ==
X-Gm-Message-State: AA+aEWZ3v/YzgAPmrVvTUSvMBTkPmKD3/8ImEOKZcNrJhd7S3VhGxywW
        WTUBHx1qBa21FPQKxik8ELSxIlh507MXAH1vZ4eax1ljyFs=
X-Google-Smtp-Source: AFSGD/VfsnsmYEOmt/gl5bHyQFMk02RUo7jjAQcNmBOAb8Yy5DxBFj7LFMZXeS2g5gwKcbIRlEJgLioRp91Z3J9i24s=
X-Received: by 2002:a24:5d5:: with SMTP id 204mr410679itl.122.1544140825489;
 Thu, 06 Dec 2018 16:00:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTUOh-QQgyEXu1HvHNqqL1kUEkTV3-SaWYDAduQLBhs9Q@mail.gmail.com>
In-Reply-To: <CAJCQCtTUOh-QQgyEXu1HvHNqqL1kUEkTV3-SaWYDAduQLBhs9Q@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 6 Dec 2018 16:00:13 -0800
Message-ID: <CACdnJutPhmizvz9mPT6-hHgXr8LjjAc0Pd9reJjgjRKL3K8Wbw@mail.gmail.com>
Subject: Re: unrecognized TMP 2.0 hardware
To:     chris@colorremedies.com
Cc:     linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 6, 2018 at 3:01 PM Chris Murphy <chris@colorremedies.com> wrote:
> [    2.066860] tpm_crb MSFT0101:00: can't request region for resource
> [mem 0x3af5b000-0x3af5b02f]
> [    2.066916] tpm_crb: probe of MSFT0101:00 failed with error -16
> [    2.324683] ima: No TPM chip found, activating TPM-bypass!

Your firmware is marking the region as ACPI_NVS and the kernel refuses
to allow a driver to allocate it. The "obvious" thing to do here is
for the kernel to allow drivers to allocate ACPI_NVS regions (since
Windows obviously works), but there's then some complexity over the
special-cased NVS save/restore code over suspend/resume.
