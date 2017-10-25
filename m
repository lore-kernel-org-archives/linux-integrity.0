Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:43219 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdJYORT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 10:17:19 -0400
Received: by mail-io0-f171.google.com with SMTP id 134so1159274ioo.0
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 07:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 25 Oct 2017 07:17:17 -0700
Message-ID: <CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
Subject: Re: Fixing CVE-2017-15361
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Kari Hiitola <kari@varaani.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> I'm implementing a fix for CVE-2017-15361 that simply blacklists
> vulnerable FW versions. I think this is the only responsible action from
> my side that I can do.

I'm not sure this is ideal - do Infineon have any Linux tooling for
performing firmware updates, and if so will that continue working if
the device is blacklisted? It's also a poor user experience to have
systems using TPM-backed disk encryption keys suddenly rendered
unbootable, and making it as easy as possible for people to do an
upgrade and then re-seal secrets with new keys feels like the correct
approach.
