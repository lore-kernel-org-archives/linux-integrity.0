Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF51EC169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 20:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4B72070C
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 20:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tb4ZLy6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfBKU6f (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:58:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50244 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBKU6e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 15:58:34 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so1835470iti.0
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 12:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Si1vP66XUZgmf4z44LbD5Oz8Z1VfJDDrmoUPYa2OgoA=;
        b=Tb4ZLy6bTp8eM1RPQUsOMHXga4kLbwBMvj2uLulPKuCohaHq1lWU+V5NrBLpPjJ4v6
         MOPbtFWedqZ4GLlZw4FfmF+OvOncI95nywgURH1P7KBeSIzBsSiQ5BrNKuYkyNedSfN3
         13xNmgDTHmFlEBSJjnyDKM+Vy+DuT3QwODsQu2UZ/g5/R+nPcULrNz1akfcxHLZAHvpt
         tVdIdQzNFRytY11Gv/lpzj2aMLHOrOZnkFgIbIKCaMEV5k329/H6jYITRt+yfDap4/GR
         DRYSKg1BHsE/Af7D2rI6JerZv9D0GyDrD/G3Jp8CNMBAZMUd7Vm5cp7aT3vn+o8VpkWT
         inDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si1vP66XUZgmf4z44LbD5Oz8Z1VfJDDrmoUPYa2OgoA=;
        b=DLirF5f/ss8BnWdRYX6wp1sm7XgDzjTr2VNoCE18nM8Z3DpIQ43yej7QIVPyjzQGVh
         LFmNxjxZau7Sj4OSIWkw9rHD+vz2E+9Fcr5t9C19u115e+NZwsih23MMsJ7USPk4Qpvz
         F8UnviJT8t9Si8XARweVeFF+3rS5ev0MWqOllWaQLePr4eXg5IRI0e3tuj3X2Zafhksj
         p6Nf7IpWKPHU0UvhoXOb+ABq5+iezcq0ic7etKalgm7hm8tJ8GSA3qQHm4AvV3QaJEhj
         AYwfsRD0I+RE1GxN/tfNksTUEYndlxwE1/LhhYl4aH6OAb35ECYKCrET1bG0c47tZ2hC
         3wuA==
X-Gm-Message-State: AHQUAubh6nBBOnl/JweXFRlo19RLkmhQuuHjuPRervnJuJfoE7z3a/zt
        UcmbcftEe764evATtjYuav0Z/VtHaIFuW98gcyxb8ClK3QM=
X-Google-Smtp-Source: AHgI3IbbDgpT5KR1JEjE4cz8fC3BVp0X/xBrZ3fOR9mZAKAITwjynkXrHYj3Su9xRMdKXpKOKJ1WdyCHtmbn/IUsydg=
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr82902ioh.169.1549918713293;
 Mon, 11 Feb 2019 12:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20190204213303.131064-1-matthewgarrett@google.com>
 <20190204213303.131064-3-matthewgarrett@google.com> <20190211163855.GF8431@linux.intel.com>
In-Reply-To: <20190211163855.GF8431@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 11 Feb 2019 12:58:21 -0800
Message-ID: <CACdnJut2tNMZvjyc=TxaxRQiuj-Xjb1pyTZgHOYxkPO-VKYM1w@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] tpm: Reserve the TPM final events table
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 8:39 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Mon, Feb 04, 2019 at 01:33:01PM -0800, Matthew Garrett wrote:
> > +int tpm2_event_log_length(void *data, int count, void *size_info)
>
> Should be a static function and for consistency's sake the name should
> be tpm2_calc_event_log_size().

Done.

> > +             size += event_size;
> > +     }
>
> Would add a newline here.

Done.

> Not really sure why this change to branching in the first part of this
> function. Would reduce the diff and review the actually relevant parts
> if you didn't do this.

Done.

> > +
> > +     if (efi.tpm_final_log != EFI_INVALID_TABLE_ADDR) {
>
> Wondering that should this function instead do right `in the beginning:
>
> if (efi.tpm_log == EFI_INVALID_TABLE_ADDR &&
>     efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
>         return 0;
>
> Feels odd condition that the log would not be invalid but the post log
> (using post would be more self-describing than final imho) would be. Can
> that legitly happen?

The spec name is final, so I kept it that way for consistency. Keeping
a separate check for the final event log is partly out of
defensiveness against firmware implementations getting this wrong -
I've definitely found implementations that just don't produce any
final events, so it wouldn't surprise me if there are some that don't
install the table.

> > +struct efi_tcg2_final_events_table {
> > +     u64 version;
> > +     u64 number_of_events;
>
> Would name this simply as nr_events as nr_ is so commonly used prefix in
> the kernel.

Done.

> >  static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > -                                     struct tcg_pcr_event *event_header)
> > +                               struct tcg_pcr_event *event_header,
> > +                               void *(*map)(resource_size_t, unsigned long),
> > +                               void (*unmap)(void *, unsigned long))
>
> Should replace with bool do_mapping instead of doing indirect calls for
> on reason (and thus introducing retpoline's). I don't think call sites
> should be enumerated. A proper kdoc would just describe parameters and
> their purpose.

Done. I'll send an updated patchset.
