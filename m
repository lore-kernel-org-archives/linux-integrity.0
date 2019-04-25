Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717BC4321A
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9619020717
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556234391;
	bh=oy9mkRIJ27E/78TIf184RjzExaYF8UiQ3DFQaz1wM3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rvBsfaohmOHVLx3QuIYv4SJNcXKhUZZ7otbIU0fEsUefut9/A04Eb4CXLNaz9EfkD
	 fuoo6E60P/sJv5M/sm4nyG0RDZwMf0CXXilF0sLoKw+woeBsWWdMtheJH2w/IAoZdS
	 9q6YL+lndo2ODvZ+zzioQUdqw5mBI7E1W2l8bnWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfDYXTu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:19:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43813 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfDYXTt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 19:19:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id i68so905773lfi.10
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVMMh5fN5ozrCrHID7oOuvIh5XNOIIl8KqXF7UDwSbM=;
        b=FdPlTG3RMyWGkT/hrEbJE6gWCmVVUw7blvL5J103CSzw5P7J1SZbN9GFwIMe8kzQ0Q
         443a6k4EK2MynrpRPzqVtPdx6RbGXzw8RIJTZPE+8McLQadG2TpJtdtYmzcCC3EtG3PM
         anXQwKgWPv6ogPlKDoh5kmY/zn33Sen4u3fuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVMMh5fN5ozrCrHID7oOuvIh5XNOIIl8KqXF7UDwSbM=;
        b=m291ggJKCyja74U8dopzV6QPygdJm8TmGIu8mvRoT++wApPpeNnfnlWXev9/uS1XTa
         TeVnkjV+mr6H54Qrh9lhACUIFewsih+1etanlJ17huL2zLuYJelxvSzYxkGgxIQcjyIH
         6DINxYA5N1CKsdyXq9ttlTjgDGDGKksZScSZhQ7SOjqeWDbQcvMjJ6cqjqaWDW3kXoPW
         d0gOzUYhr8D0fdS1uwbq3bSUREs+BJ3XtRkvyjM1FSgCjaJixF22ELGDNQCMjOSH2Se/
         UkxclSHs79pAB7dbb1y+PvAfR4gXOsS/oyerUp2T8r9d/B8HsaJHnppKl5j+NoIirAXe
         VPbA==
X-Gm-Message-State: APjAAAU2uQbEYA133WVFNDNaUihsu9IhapWmPE5RwbCIrHKnZanOUfKv
        G4gz6hY03VnKnJ7Y3V12q0U3IoMQFZk=
X-Google-Smtp-Source: APXvYqww9od5Oyi5U2woRtnBYSqdT0v2TgHAHxb3z7IGwOUzOtS1TUWQBuXAtgqFMiixy9UHLqwcTQ==
X-Received: by 2002:a19:e30b:: with SMTP id a11mr22411702lfh.4.1556234386845;
        Thu, 25 Apr 2019 16:19:46 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id o7sm22202ljh.57.2019.04.25.16.19.45
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:19:45 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j11so1072839lfm.0
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 16:19:45 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr21325408lfb.11.1556234385341;
 Thu, 25 Apr 2019 16:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190424001544.7188-1-prsriva02@gmail.com> <20190424001544.7188-2-prsriva02@gmail.com>
 <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com> <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
 <CAADWXX8NC-PFJmuvQbNXn49CYjvyn-e0rtH_EoUfCvuJHTwHAQ@mail.gmail.com> <alpine.LRH.2.21.1904260833140.7315@namei.org>
In-Reply-To: <alpine.LRH.2.21.1904260833140.7315@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 16:19:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4RdXiy4JTPJ5tcFAsjQe1a9+C9_35Y0m6wrjY8nQVgw@mail.gmail.com>
Message-ID: <CAHk-=wg4RdXiy4JTPJ5tcFAsjQe1a9+C9_35Y0m6wrjY8nQVgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
To:     James Morris <jmorris@namei.org>
Cc:     prsriva <prsriva@linux.microsoft.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 25, 2019 at 3:34 PM James Morris <jmorris@namei.org> wrote:
> >
> > Please fix.
>
> It's the correct SMTP server for linux.microsoft.com.

In that case, it seems that your SMTP server is misconfigured, and
shouldn't be used.

> linux.microsoft.com.    3600    IN      TXT     "v=spf1 ip4:13.77.154.182 -all"
> linux.microsoft.com.    3600    IN      TXT     "v=DMARC1;p=none;pct=100;rua=mailto:jamorris@microsoft.com"
>
> We don't have DKIM set up yet.

I get

       dmarc=fail (p=REJECT sp=REJECT dis=QUARANTINE) header.from=microsoft.com

because the microsoft.com DMARC rules will be triggered before the
"linux.microsoft.com" rules are.

                   Linus
