Return-Path: <SRS0=rf2w=62=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F31CA90AF
	for <linux-integrity@archiver.kernel.org>; Tue, 12 May 2020 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF40206DD
	for <linux-integrity@archiver.kernel.org>; Tue, 12 May 2020 17:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I28q1pZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgELRqJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 May 2020 13:46:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36071 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgELRqJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 13:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589305568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlHK3MD9mslQAtaYQzirsJP3rdEAoipwCXorCnBdiew=;
        b=I28q1pZth5Uilj1VllM0y1vG6m0YYzQvc+X874ta66trqdcbL1eFOLEHawwlyiu5EH9Fnc
        KNX6HVgC0quk0kP9N32WkhNmVLULJurRVGOlqvN52qiWMlOnTn68q/5DGDEftAcyJH9qEd
        FP9tdweQ77PvOneUB2AikW1s5S39eKQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-vG7q-43sOzOgXCGerf9v2A-1; Tue, 12 May 2020 13:46:06 -0400
X-MC-Unique: vG7q-43sOzOgXCGerf9v2A-1
Received: by mail-lf1-f70.google.com with SMTP id 74so5094195lfn.4
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 10:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VlHK3MD9mslQAtaYQzirsJP3rdEAoipwCXorCnBdiew=;
        b=rabdaIacwcCuyz6HxPwX91SkpMYj9+mdq92+XOXSThk9sDTgY6mFU2z/IoO6o97lu5
         2dM5I0YfrhCGhE+Gt9MnI65kXiqRZz2/sosew+ImBnxuC+51YapRX3TyoXch7L7UvMZZ
         +TpTZzaW9JBxLvTzvUgEE1jAhR0FEzsD9TlmBdhuY6begNCRS4dWn4LinW6dn6gq525v
         lLwd3EwaVZN4Tm5NbF2GH3Bn/wcxAGXEKZIT+afjNuSl2Q57shBiRbGz17OaRYdD4G0A
         wmvcOcI8tz1sSEQ8zR82nxNQW9CCTR2lPh5WUAJFgo67ExsdmINIU8yODmh6O34RbI1a
         HKWA==
X-Gm-Message-State: AOAM533r+uIXnsu5dYaLZwklg50KWOuOt4Ep4zZNr5p3A787wT8RwMDp
        1by+lw9++fLBPQPptSQDi8yKbAudj632CJvBxnGt+o+l6wGlXt7dlVBx9Fs5c9RRH31ExGmiZbq
        HiWo25ZOr6aRsmUkfdq4+nBR1D0OiEMDYMbMBa5S0KFAd
X-Received: by 2002:a19:d55:: with SMTP id 82mr15462497lfn.89.1589305565165;
        Tue, 12 May 2020 10:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2rJ7GkPyduqApdhohXjMBvp1QWYTQ9kph1gg5Iet5LK7XYhRimhH3mknNMnGMFIY/8nws8y4z70rY47juR3I=
X-Received: by 2002:a19:d55:: with SMTP id 82mr15462483lfn.89.1589305564897;
 Tue, 12 May 2020 10:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
In-Reply-To: <20200512040113.277768-1-loic.yhuel@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Date:   Tue, 12 May 2020 19:45:53 +0200
Message-ID: <CAFOAJEfFcL5EYXnwd=Yqdj065efD2ojYVjpJ+4rOZqGcxmTAsA@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Lo=C3=AFc,

On Tue, May 12, 2020 at 6:02 AM Lo=C3=AFc Yhuel <loic.yhuel@gmail.com> wrot=
e:
>
> This fixes the boot issues since 5.3 on several Dell models when the TPM
> is enabled. Depending on the exact grub binary, booting the kernel would
> freeze early, or just report an error parsing the final events log.
>
> We get an event log in the SHA-1 format, which doesn't have a
> tcg_efi_specid_event_head in the first event, and there is a final events
> table which doesn't match the crypto agile format.
> __calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
> either fails, or loops long enough for the machine to be appear frozen.
>
> So we now only parse the final events table, which is per the spec always
> supposed to be in the crypto agile format, when we got a event log in thi=
s
> format.
>
> Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
> Fixes: 166a2809d65b2 ("tpm: Don't duplicate events from the final event l=
og in the TCG2 log")
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779611
> Signed-off-by: Lo=C3=AFc Yhuel <loic.yhuel@gmail.com>
> ---

As you mention, that's what the TCG EFI Protocol Specification says
about the EFI Final Events Table so I agree with your patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

