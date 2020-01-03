Return-Path: <SRS0=9D2J=2Y=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23FDC2D0C2
	for <linux-integrity@archiver.kernel.org>; Fri,  3 Jan 2020 20:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8141D20866
	for <linux-integrity@archiver.kernel.org>; Fri,  3 Jan 2020 20:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giBmq6w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgACUZG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:25:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728376AbgACUZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 15:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578083105;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=vIYQkD20DtDkAZnR5HqwGi0y1CPUBys+0A8WZjYWNOA=;
        b=giBmq6w8robY7ZbKIAXR1AfZfBXC5Pn4Ea+1+O93uOJFB24IkXDymOFMy4e7FbclLJKmiv
        4fsCA0ZyFtZbCtXKxqguSHBcOUgHJzJ5SgKVOxz+C9ALHwdmrJlE91XvK8wZaYcj+OuPCe
        lq83J1z7ZobXNdyOu52C8veNaL3asc8=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-KHJKG4EzPs-BgprnHdf9Ww-1; Fri, 03 Jan 2020 15:25:01 -0500
X-MC-Unique: KHJKG4EzPs-BgprnHdf9Ww-1
Received: by mail-yw1-f69.google.com with SMTP id r189so35114846ywf.13
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 12:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vIYQkD20DtDkAZnR5HqwGi0y1CPUBys+0A8WZjYWNOA=;
        b=P8Q3rrjmolR5GKM1of2+RazbA71brHlBdWhaot5hu8VOu6ieXHIPM25obWXXd/wxzD
         Hwz0rGk1Nzmj5fHfSvPIhWGeSgWsL3pb9lfGUIJIJyJIH6Ey1KwzjFPh03d6KRgZHl/z
         2zhO/scg1FO7oTydRHXlpVuAS2bOOwfOwqo2YE94l28HDkl9WTEEmdCtvniU5fAD/5TH
         6NXK0G26+JPOaJvceAnglUd7C6rR5LSkmuw9HAZ76YvvIMhaqn1qetYSJM7VRslgSlEb
         1QgHT0TXFLhT97LaaR7722OjTeYWLF7fE7Bu5GMU1hV2X1cVj97Glr/I2jAwMfDuwQRv
         B/qg==
X-Gm-Message-State: APjAAAV+7ki5S86c9v2/yE7Kxl0/n8/i6wqq1iUjRnkHfVHN1F0odNGW
        nRFj6QRjYELHSPcHBqxO6T4yvbAbqRdJ1u9WvYb150pA0nc1MxxX4RkTBVVgzxCmsbNPIml5pY3
        +QdPTcisLZOH/u8XIj+5tmMQE4XGX
X-Received: by 2002:a25:9309:: with SMTP id f9mr70238567ybo.43.1578083101429;
        Fri, 03 Jan 2020 12:25:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZ8DLvTkRCvsFLSCltnpCvU/x9tELkKy1E6VFlp20keNhZqqn+vEyv92etdhVLppcchXVF5Q==
X-Received: by 2002:a25:9309:: with SMTP id f9mr70238553ybo.43.1578083101116;
        Fri, 03 Jan 2020 12:25:01 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id c84sm24230987ywa.1.2020.01.03.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 12:25:00 -0800 (PST)
Date:   Fri, 3 Jan 2020 13:24:58 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20200103202458.lhd5qu2onl67kilb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor>
 <20191231155944.GA4790@linux.intel.com>
 <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
 <20200102171922.GA20989@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200102171922.GA20989@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jan 02 20, Jarkko Sakkinen wrote:
>On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
>> > Christian, were you having any issues with interrupts? You system was going
>> > into this code as well.
>>
>> Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
>> with UEFI firmware and the problem has disappeared. Please let me know if there
>> is anything else I can do to help.
>>
>> Christian
>
>Takashi wrote yesterday [*]:
>
>"I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
>patches"
>
>[*] https://bugzilla.kernel.org/show_bug.cgi?id=205935
>
>/Jarkko
>

You can add my ack to the reverts.

