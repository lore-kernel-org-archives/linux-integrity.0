Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B1C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D53F20700
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 17:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpbasQqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCSRHx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:07:53 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:54703 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSRHw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Mar 2019 13:07:52 -0400
Received: by mail-it1-f180.google.com with SMTP id w18so27124604itj.4
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2019 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aijo3h8IgvWxOJZmZiH/s4I12tNA6oxdL68NjyAydgk=;
        b=NpbasQqtffRmLW/FM79liiBDeafefjrEp4sA8OmAbqm363LTRcaO6LTLcWIPTWjege
         IGWILtEnwxZdX15Kxi1LjtvgJAnYlzXbEflfOAoUlmLJLEC9x+y2DKpn0j5tvr5w7uCV
         Mr5iS6jDhyhnYuoQfUz4HWaEK7qJc0Za8uhIPA54O2avWNBA/c9p53+iIJRme79k97Xl
         Xhxg8MfPdyXENyAnbcAg7Jr/6O0jIgdWUug5dP8ot7MY6w1SutjXdevMvV0eSGVRv8Nz
         TpTDZpohrCJ1ggNfCj0imGqXmI1XSeGchdLg2seyBHKLhO8A4fRpC5u/gdDfSqKhNK2j
         X8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aijo3h8IgvWxOJZmZiH/s4I12tNA6oxdL68NjyAydgk=;
        b=rbULqQ9bYDYITfi9GJemRc8UM1dz8Vrxhay3IVYAm9gtydggmcxZXVvaSr2Owy5fc9
         FAvtM8ORnP69ZKpMARGVALzWrL/fbv5bYTwoEVpy9vfUOpu8CYl9kmBM6nI8QVmGi2hH
         KSrqTGKCVTaUw8GhpXx9nQm/TN0FebnakKPbo6yXl3Mu256cxmkD3xOZbm+XXWOIaJDw
         OVws9x70zotR5/NrlndFHi4/wHg8NQ0pqLYaKV9pJ52w5X+4Am8y39RJFC131s2SPUgG
         rJlm4ivMu+kMRX7FIfex8Eb/ojB6pilPzZlIIoTtpxK6PDTT45Q/kimNNYD2ofbXuq7I
         aJjA==
X-Gm-Message-State: APjAAAVDucfiGK0yGm+23Dpq8jEOIwbmwJvw4pAdEl4/4xEnKrwTt3pm
        4AzVL/a3vqaenYImRr9R4P6DmIVDrBzKj2lYCprO8pFl7Q0=
X-Google-Smtp-Source: APXvYqwYm6tsAyOwPf7rWYg80Qf+qMDnc2OT8W4rJxEkWIlaWXGUnEqQ49V/vn/JoqpEP4B0av4ka3sXHCMCSfhZvZs=
X-Received: by 2002:a02:240d:: with SMTP id f13mr2240586jaa.105.1553015271704;
 Tue, 19 Mar 2019 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com> <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
In-Reply-To: <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 19 Mar 2019 10:07:39 -0700
Message-ID: <CACdnJusM4gPwfo8x7fzFcF6Yzhn++v=G67V-nhXgo37uHZT9EQ@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 19, 2019 at 5:19 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> I think that checking the integrity at least in the case when the file is
> still open is better than not checking at all. Because as I said it would
> be possible to use mmap+mprotect to bypass IMA for shared libraries checking.

Remember that an application can also open a file read-only and then
execute the code under an interpreter. If you have code that's
deliberately trying to undermine IMA then it can do so - the goal is
to use IMA to ensure that you have appropriate measurement or
appraisal in order to avoid that in the first place.
