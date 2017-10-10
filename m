Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:54872 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbdJJXY3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2017 19:24:29 -0400
Received: by mail-io0-f175.google.com with SMTP id h66so445126ioh.11
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 16:24:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010225906.16771-1-mjg59@google.com>
References: <20171010225906.16771-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 10 Oct 2017 16:24:27 -0700
Message-ID: <CACdnJusvKDMYBamoQH1Q81YbCkNzPnEjpG590sNpqSjaQSEuFw@mail.gmail.com>
Subject: Re: [PATCH V2] IMA: Add support for IMA validation after credentials
 are committed
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Actually, hold off on this for a little - there may be a better way to do this.
