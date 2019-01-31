Return-Path: <SRS0=eEpa=QH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B25BC282D9
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 18:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1998218EA
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y5fzDDzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfAaSwo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:52:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39383 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfAaSwo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Jan 2019 13:52:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so3607702ljh.6
        for <linux-integrity@vger.kernel.org>; Thu, 31 Jan 2019 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoPq2Gpjoh5/AheroPKAuShVwRAXgiAMRb9VhOJl20s=;
        b=Y5fzDDzXBklrXEuCnqUbsCilsPuxjCIUVOAtKnUNWmbDkhaL3DibOJ0aP2qWpLw4yR
         5YcIFLfYmBeuEAeuCFCzpa0J3WGL4f6HQ82Z79/KW7n7yk4dtHw0v2i6fuZesG2ElVFi
         BCYoPrG6IPhCKs+00BwRvePwc1x9Uel7ZdGHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoPq2Gpjoh5/AheroPKAuShVwRAXgiAMRb9VhOJl20s=;
        b=U+yENyaHeQrB3m4XT8VFlB1HCQj5nSflUpWTVRmdcgyJPf+Mtj61HSa38//uLpN3Ig
         p/aE15uWmp++HAnXu1qadlC8mDNOA2aZonMF98sOTqFD569OJEQ/gQfEQIzVBl/kcwQ/
         PmWL6ooxP89E1RU9hT3ZKGfvrg1SGD8g6AyYF0yuqJRhXW42TIcwnH9QGLw57+H/lT+q
         wfCNa2WRmJxqYdk1VJBffhjfNwWwDlyDrpF7IEGFiaothXw0McNTvoyZIMhR2iNplxJW
         CXekNPAiJ/fIW9tjtwZ1vGJwvN+VVtUzRjK5XN5vWa9r8Xp6QS9v1kP4h5Hni9yD9EJZ
         trkA==
X-Gm-Message-State: AHQUAuamJ2TKTH/JXCioiPBmo7JS5+4Y9YlfkUePiooW+w/x/A9rhcku
        VA5CCdvm1kX97qSxQe+CopEiwRSgnmI=
X-Google-Smtp-Source: AHgI3IbV7PmqH4cLksivd98qomOWvHtK562NzK96BGa+w0fg4ZglLDtm3f7eF9MzxxeYLfkpfL6TSA==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr4803678ljh.59.1548960761594;
        Thu, 31 Jan 2019 10:52:41 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f8sm1095379lfe.72.2019.01.31.10.52.40
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:52:40 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id n18so3138610lfh.6
        for <linux-integrity@vger.kernel.org>; Thu, 31 Jan 2019 10:52:40 -0800 (PST)
X-Received: by 2002:a19:980f:: with SMTP id a15mr27881838lfe.103.1548960759863;
 Thu, 31 Jan 2019 10:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20190122010218.GA26713@linux.intel.com> <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com> <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
In-Reply-To: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 10:52:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
Message-ID: <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 31, 2019 at 10:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In fact, we have another patch (that isn't applied) that makes even
> the memcpy_erms() just call the sw version of memcpy() for short
> copies (because "rep movsb" is slow for those cases). That would also
> have broken your driver.

I think what I should do is to just make "memcpy_*io()" do the "align
naturally" thing.

Let me cook up a patch for you to test.

              Linus
