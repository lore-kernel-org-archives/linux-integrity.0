Return-Path: <SRS0=nhA0=54=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFDDC2BA2B
	for <linux-integrity@archiver.kernel.org>; Sun, 12 Apr 2020 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76FB206E9
	for <linux-integrity@archiver.kernel.org>; Sun, 12 Apr 2020 15:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20150623.gappssmtp.com header.i=@easyb-ch.20150623.gappssmtp.com header.b="i7Z8Lvye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLPCc (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 12 Apr 2020 11:02:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53264 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLPCb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Apr 2020 11:02:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so7229869wmd.3
        for <linux-integrity@vger.kernel.org>; Sun, 12 Apr 2020 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yqa+EKJqOMZqIixsYzmlt55IzP82TkpcbHu7uxFT4o=;
        b=i7Z8LvyenibZTZyXkEsEEE3K8RDOujJ5674sYvNfURpQHNE2oBiWWT7e/r2jmyhWQD
         y1+2fnERImX69QvnWOISWrNrpamrprTbjTLcqfhrku9LoEMEmGG9qEuMsikEqSsaxSqK
         Y79t6ml2mxu6Bg8wZRcptCDJfETVDXs2SZK8GQltSXQNOiaJe/6CdZyheSlXoFomAFYU
         BHejmk7ZGe37MV75QLmNKF23jBsXVadUdm/DzLwRTeJn8gbN5K6kRtSZybzhaMVIOrrG
         kkpACiuBfCAkHXBTZasQv7jicUw7dN29mk5V0RP+E4nBX49iA5hmeuiTzHvVhCaBoAUV
         g05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yqa+EKJqOMZqIixsYzmlt55IzP82TkpcbHu7uxFT4o=;
        b=V7pvCMFDreHo27HzTm6zAYFavTSoAqFuTr/2rbSNkpNgLExjLkYuHAN0KpPxXNHpdh
         1wc+a9U8m5Ef8IG3EOs6iUSfI7c0Yfia0y76VYFilRCtXRbuAYIID7vlUTXK4w2W3FJS
         EYGG5ZvXkryN63I1DQEAnOqWt8Ijmv1lQlLgYOocvwBAJ/q3OXl0VcyY6FDyoTWCaxQu
         loQcQ0BxTmkKaTjaPJBs4gPlctrfK3Gz682LWb1PaEJXSUixkCBTTKaWhWSqUxnD1I8a
         vKL8kq48Gq/mYcDU/od8nbLkKh/6WurYN6L3EnFtHiCtUqln/BsCa2Y2jiylizDxJaYe
         d2OA==
X-Gm-Message-State: AGi0PuYeI6cRC0XlnSGHvaImsDO7UIAOKrtwse2n8TfxsebWiQeUTPkW
        FY2DZM2mSAd9BVIHURYfGuh/NA==
X-Google-Smtp-Source: APiQypJ5G4BL6g1G/EhYOU8fMFTZs+je8F9lWXNuf0JLZA90eJeTelxDQNlTSUguKI6gLklzRQKBzw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr14005777wme.159.1586703750678;
        Sun, 12 Apr 2020 08:02:30 -0700 (PDT)
Received: from ?IPv6:2001:1715:4e3a:130:cca:5c89:8758:a721? ([2001:1715:4e3a:130:cca:5c89:8758:a721])
        by smtp.gmail.com with ESMTPSA id i13sm5808364wro.50.2020.04.12.08.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 08:02:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
From:   Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
Date:   Sun, 12 Apr 2020 17:02:27 +0200
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkkon,

> On 12 Apr 2020, at 16:36, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
> +        except ProtocolError(e):

Should this not be

        except ProtocolError as e:

?

Cheers,
Ezra.

